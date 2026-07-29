import { useState } from "react";
import type { ShiftEntry, BudgetItem, FatigueExpense, SavingsGoal, Debt } from "./types";

function App() {
  const [shiftEntries, setShiftEntries] = useState<ShiftEntry[]>([]);
  const [budgetItems, setBudgetItems] = useState<BudgetItem[]>([]);
  const [fatigueExpenses, setFatigueExpenses] = useState<FatigueExpense[]>([]);
  const [savingsGoals, setSavingsGoals] = useState<SavingsGoal[]>([]);
  const [debts, setDebts] = useState<Debt[]>([]);

  return <div>App state initialized</div>;
}

export default App;