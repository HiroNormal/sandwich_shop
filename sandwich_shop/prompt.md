sGoal
Implement the following cart modification features. For each feature include UI changes, user interactions, model updates, validation, visual feedback (snackbars/dialogs), and automated tests.

Features (for each item below implement UI, logic, and tests)

1) Increase / Decrease quantity inline
- Description: Allow user to increment or decrement the quantity of an item directly in the cart row (± buttons).
- When user taps "+":
  - Immediately increment the quantity in the local UI.
  - Update the Cart model and cart summary (item count, total price).
  - Persist change in the Cart instance and reflect in any global cart state.
  - If quantity reaches defined max (use maxQuantity from OrderScreen or Cart.max if available), disable "+" and show a brief Snackbar: "Max quantity is X".
- When user taps "–":
  - Decrement quantity (but not below 1).
  - Update model and UI immediately.
  - If user wants to reduce to 0, require explicit "Remove" (see feature 3).
- Acceptance criteria:
  - Row shows updated quantity and item subtotal.
  - Cart total updates immediately.
  - Buttons disabled appropriately at min/max.

2) Edit quantity via direct input
- Description: Allow tapping the quantity number to open a small dialog/number picker to enter a quantity.
- When user taps quantity:
  - Open modal with numeric text field or picker prefilled with current quantity.
  - Validate input (integer >=1 and <= max).
  - On "Save": update Cart model and UI, close dialog, show Snackbar "Quantity updated".
  - On invalid input: show inline error and do not save.
- Acceptance criteria:
  - Dialog validation works, model and UI update on Save.

3) Remove item (explicit)
- Description: Allow user to remove an item from the cart with an action button (trash icon) in the row.
- When user taps "Remove":
  - Show confirmation dialog "Remove this item?" with Cancel / Remove.
  - If user confirms: remove item from Cart model, update UI and totals, and show Snackbar "Item removed" with an "UNDO" action.
  - If user taps UNDO within Snackbar duration: restore the removed item and update totals.
  - Edge case: If removing the last item, navigate to empty-cart state/screen or show a friendly empty view.
- Acceptance criteria:
  - Removal requires confirmation or offers undo.
  - Undo restores exact item (type/options/quantity).

4) Edit item options (sandwich type, size, bread)
- Description: Allow user to edit sandwich options for a cart item (opens an edit screen or modal pre-filled with the item's choices).
- When user taps "Edit":
  - Open modal/screen with same selectors as OrderScreen (sandwich type dropdown, size switch, bread dropdown, quantity).
  - Pre-fill current item values.
  - On Save: validate and replace the item in Cart (update model and UI). If the edited item is equivalent to an existing cart item (same type/options), merge quantities instead of creating duplicate rows.
  - Show Snackbar "Item updated" with undo.
- Acceptance criteria:
  - Editing updates the Cart model and UI.
  - Merging duplicates increments quantity correctly (respect max limit and notify if truncated).
