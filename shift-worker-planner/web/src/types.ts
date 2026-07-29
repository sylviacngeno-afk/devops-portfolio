// ============================================================================
// 1. Budget Items
// ============================================================================

export interface BudgetItem {
  id: string;
  category: string;
  expenseType: "Fixed" | "Variable";
  budgeted: number;
  actualSpent: number;
}

export function variance(item: BudgetItem): number {
  return item.budgeted - item.actualSpent;
}

// ============================================================================
// 2. Shift Entries
// ============================================================================

// Common shift types: "Day" | "Night" | "Overtime" | "On-Call"
export type CommonShiftType = "Day" | "Night" | "Overtime" | "On-Call";

export interface ShiftEntry {
  id: string;
  date: string;
  shiftType: string;
  baseHours: number;
  otHours: number;
  baseRate: number;
  otMultiplier: number; // e.g., 1.5 for time-and-a-half, 2.0 for double time
  shiftDiff: number;    // Flat $/hr bonus for night/weekend differentials
}

export function estGrossPay(entry: ShiftEntry): number {
  const effectiveBaseRate = entry.baseRate + entry.shiftDiff;
  const effectiveOtRate = (entry.baseRate * entry.otMultiplier) + entry.shiftDiff;

  const basePay = entry.baseHours * effectiveBaseRate;
  const otPay = entry.otHours * effectiveOtRate;

  return basePay + otPay;
}

export function totalBaseHours(entries: ShiftEntry[]): number {
  return entries.reduce((sum, entry) => sum + entry.baseHours, 0);
}

export function totalOtHours(entries: ShiftEntry[]): number {
  return entries.reduce((sum, entry) => sum + entry.otHours, 0);
}

export function totalGrossEst(entries: ShiftEntry[]): number {
  return entries.reduce((sum, entry) => sum + estGrossPay(entry), 0);
}

// ============================================================================
// 3. Fatigue Expenses
// ============================================================================

// Common fatigue expense categories
export type CommonFatigueCategory = "Takeout" | "Convenience" | "Rideshare" | "Coffee";

export interface FatigueExpense {
  id: string;
  date: string;
  category: string;
  amount: number;
  primaryTrigger?: string;         // What schedule event caused the spend (e.g. "Quick turnaround night shift")
  fatigueMitigationIdea?: string;  // Idea to avoid spend next time (e.g. "Batch cook pre-night shift")
}

export function totalFatigueSpend(expenses: FatigueExpense[]): number {
  return expenses.reduce((sum, item) => sum + item.amount, 0);
}

// ============================================================================
// 4. Savings Goals
// ============================================================================

export interface SavingsGoal {
  id: string;
  name: string;
  targetAmount: number;
  currentAmount: number;
  targetDate?: string;
}

export function percentComplete(goal: SavingsGoal): number {
  if (goal.targetAmount <= 0) return 0;
  return (goal.currentAmount / goal.targetAmount) * 100;
}

export function amountRemaining(goal: SavingsGoal): number {
  return Math.max(0, goal.targetAmount - goal.currentAmount);
}

// ============================================================================
// 5. Debts
// ============================================================================

export interface Debt {
  id: string;
  name: string;
  currentBalance: number;
  minimumPayment: number;
  interestRate: number;
}

export function totalDebtBalance(debts: Debt[]): number {
  return debts.reduce((sum, debt) => sum + debt.currentBalance, 0);
}

export function totalMinPaymentRequired(debts: Debt[]): number {
  return debts.reduce((sum, debt) => sum + debt.minimumPayment, 0);
}