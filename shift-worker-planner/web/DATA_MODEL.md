BudgetItem
- id: string
- category: string        ("Rent", "Groceries", "Subscriptions"...)
- expenseType: "Fixed" | "Variable"
- budgeted: number
- actualSpent: number
// derived: variance = budgeted - actualSpent
FatigueExpense
- id: string
- date: string
- item: string           ("DoorDash", "Energy drinks"...)
- cost: number
- trigger: string         ("Post-night-shift exhaustion"...)
- mitigationIdea: string
// derived (collection-level, not per-row): totalFatigueSpend = sum(cost)
SavingsGoal
- id: string
- name: string            ("Emergency Fund", "Vacation & Recovery"...)
- currentAmount: number
- targetAmount: number
// derived: percentComplete = currentAmount / targetAmount
// derived: amountRemaining = targetAmount - currentAmount
Debt
- id: string
- creditorName: string
- balance: number
- interestRate: number    (%)
- minPayment: number
// derived (collection-level): totalDebtBalance = sum(balance)
// derived (collection-level): totalMinPaymentRequired = sum(minPayment)
ShiftEntry
- id: string
- date: string
- shiftType: string       ("Day", "Night", "Weekend", "Holiday"...)
- baseHours: number
- baseRate: number         ($/hr)
- otHours: number
- otMultiplier: number     (e.g. 1.5)
- shiftDiff: number        ($/hr differential, e.g. night shift bonus)
// derived (per-row): estGrossPay = (baseHours * baseRate)
//                                + (otHours * baseRate * otMultiplier)
//                                + (baseHours * shiftDiff)
// derived (collection-level): totalBaseHours = sum(baseHours)
// derived (collection-level): totalOtHours = sum(otHours)
// derived (collection-level): totalGrossEst = sum(estGrossPay across rows)