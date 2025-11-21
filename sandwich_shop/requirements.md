# Cart Item Modification — Requirements

## 1. Feature summary
Enable users to modify items already added to their cart. Modifications include inline quantity changes, direct quantity editing via a dialog, explicit removal with confirmation + undo, editing item options (sandwich type/size/bread), and optional bulk-delete. Changes must update the Cart model and UI atomically, validate against max quantity rules, and provide clear visual feedback (SnackBar/dialogs). Automated unit and widget tests are required.

---

## 2. Goals & purpose
- Let users adjust cart contents without re-building orders from scratch.
- Keep UI state and the underlying Cart model synchronized.
- Prevent invalid states (e.g., quantity < 1, exceeding max).
- Provide reversible destructive actions (UNDO).
- Maintain accessibility and responsive behavior.

---

## 3. User stories

- As a shopper, I can increment or decrement an item's quantity from the cart row so I can quickly change how many of an item I want.
- As a shopper, I can tap the quantity to open a numeric dialog so I can type an exact quantity.
- As a shopper, I can remove an item with confirmation and undo so I can correct accidental deletes.
- As a shopper, I can edit an item's options (type, size, bread, quantity) so I can change my selection without starting a new order.
- As a power shopper, I can select multiple items and delete them in bulk (optional) so I can tidy my cart faster.
- As a visually impaired user, I can use clearly labeled buttons and semantics to perform modifications.

---

## 4. Feature details (per capability)

### A. Inline Increase / Decrease Quantity
- UI:
  - Row-level plus (+) and minus (–) icon buttons next to quantity and an item subtotal label.
  - When minus would bring quantity to 0, keep it disabled; show explicit Remove action for deletion.
- Interaction:
  - Tap "+" → immediately increment displayed quantity and subtotal.
  - Tap "–" → immediately decrement (minimum 1).
- Model updates:
  - Call Cart.updateQuantity(itemId, newQuantity) or equivalent inside a single setState (or state-manager transaction).
  - Update cart summary (item count, total).
- Validation & feedback:
  - If newQuantity > maxQuantity → do not increment; disable "+" and show SnackBar "Max quantity is X".
  - Disable "–" when quantity == 1 (so removal is explicit).
- Edge cases:
  - If increment would cause quantity to exceed available stock (if applicable), block and show message.

### B. Edit Quantity via Direct Input
- UI:
  - Tapping the quantity number opens a modal dialog with integer-only field or number picker, Cancel and Save buttons.
- Interaction:
  - Prefill with current quantity.
  - On Save: validate integer and range [1, max].
- Model updates:
  - On valid Save → update Cart model and UI, close dialog.
- Feedback:
  - On success → SnackBar "Quantity updated".
  - On invalid input → show inline error text in dialog, do not close.
- Acceptance:
  - Dialog blocks non-integer characters; prevents out-of-range values.

### C. Remove Item (explicit) with confirmation + undo
- UI:
  - Trash icon in the row or a contextual Remove button.
  - Confirmation dialog: "Remove this item?" Cancel / Remove.
- Interaction:
  - Confirm → remove item from Cart model and UI.
  - Show SnackBar "Item removed" with an "UNDO" action.
  - UNDO within SnackBar duration restores the removed item (same options & quantity).
- Model updates:
  - Removal should return a serializable snapshot used for undo.
  - Undo re-adds snapshot to Cart exactly as before (merge logic described below).
- Edge cases:
  - Removing last item → show empty-cart UI (friendly message or navigate to OrderScreen).
  - If undoable state window expires, deletion is final.
- Feedback:
  - Use undo SnackBar; include accessible semantics.

### D. Edit Item Options (type, size, bread, quantity)
- UI:
  - Edit button per row opening an edit modal/screen that replicates OrderScreen controls (sandwich type dropdown, size switch, bread dropdown, quantity controls).
  - Prefill controls with the cart item values.
- Interaction:
  - User changes options and taps Save.
  - If edited options match an existing cart row, merge quantities (respect max).
  - Show SnackBar "Item updated" with UNDO.
- Model updates:
  - Replace the old item or merge into existing item(s) atomically.
  - If merging would exceed maxQuantity, cap at max and show a SnackBar like "Quantity capped at X".
- Edge cases:
  - Editing to duplicate an existing entry → merge rather than create duplicate rows.
  - Merging overflow must be communicated and applied deterministically.
- Feedback:
  - Provide success and error SnackBars; allow undo of the edit (restore prior state).

### E. Bulk Actions (optional)
- UI:
  - Multi-select mode (checkbox per row), action bar with "Delete selected".
- Interaction:
  - Delete selected → confirmation dialog → on confirm remove all selected and show undo SnackBar that restores all removed items.
- Model updates:
  - Batch remove with a single transactional update and a snapshot for undo.
- Edge cases:
  - Mixed merges/restores must preserve original item options and quantities.

---

## 5. Acceptance criteria (when feature is done)

General
- All cart modifications update the Cart model and the visible cart summary (item count and total price) immediately.
- All changes are atomic from the user's perspective: UI updates occur only when the model is updated.
- Actions provide SnackBar or dialog feedback and have appropriate accessibility labels.
- Max quantity and validation rules are enforced consistently.
- Undo is available for destructive actions and restores exact previous state (options + quantity).

Per-feature
- Inline quantity change:
  - '+' increments until max then becomes disabled; SnackBar appears on attempt to exceed.
  - '–' decrements to minimum 1 and becomes disabled at 1.
  - Subtotal for the row and overall total update instantly.

- Edit via dialog:
  - Dialog enforces integer input, enforces 1..max and only closes on valid Save.
  - On Save, model & UI reflect new quantity and SnackBar "Quantity updated" appears.

- Remove item:
  - Removal requires confirmation.
  - After confirm, item is removed and SnackBar with UNDO appears.
  - Undo restores exact item; totals update accordingly.
  - If last item is removed, cart UI shows an empty-cart state.

- Edit item options:
  - Edit screen pre-fills values.
  - Save replaces/merges items in the cart.
  - Merging increases quantity of target row and caps at max; user is notified if capping occurs.
  - SnackBar "Item updated" with UNDO restores previous state.

- Bulk delete (if implemented):
  - Works for multiple items with confirmation + undo.
  - Restores exact set of removed items on undo.

Testing
- Unit tests:
  - Cart.add/add with merge, Cart.updateQuantity, Cart.remove, Cart.undoRemove, merge overflow behavior.
- Widget tests:
  - Inline increment/decrement updates UI and totals.
  - Quantity dialog validation and saving behavior.
  - Remove confirmation + undo restores item.
  - Edit modal prefill/save merges correctly.
- Tests cover edge cases: max quantity reached, removing last item, merge overflow.

---

## 6. Implementation subtasks (suggested)

1. Models & APIs
   - Review and add methods: Cart.updateQuantity(itemId, quantity), Cart.removeItem(itemId) -> returns snapshot, Cart.restoreSnapshot(snapshot), Cart.editItem(itemId, newItem, quantity).
   - Ensure Cart reports itemCount and totalPrice.

2. UI: Cart screen
   - Add row controls: +, −, quantity tappable, Edit, Remove.
   - Add item subtotal display.
   - Add empty-cart view.

3. Dialogs & screens
   - Implement QuantityEditDialog.
   - Implement ItemEdit modal reusing OrderScreen controls.

4. Undo & feedback
   - Implement SnackBar undo pattern with snapshot restore functions.

5. Validation & constraints
   - Add maxQuantity constant accessible to both OrderScreen and Cart logic.
   - Show SnackBar messages for capped merges or max attempts.

6. Tests
   - Unit tests for Cart model changes and undo.
   - Widget tests for cart screen behaviors and dialogs.

7. Docs
   - Short README section describing undo semantics and max quantity rule.

---

## 7. Non-functional requirements
- Use current app styling (app_styles.dart).
- Keep changes minimal and consistent with existing code style and patterns (setState/local state).
- All dialogs and SnackBars must be accessible and localized-ready (strings centralized if possible).
- Performance: no full-screen refresh required for per-row updates.

---

## 8. Definitions & assumptions
- maxQuantity value is available from OrderScreen or Cart; default to 10 if not configured.
- Cart identifies items by a deterministic key derived from sandwich options (type/size/bread) + unique id if needed.
- Pricing logic remains in pricing_repository or Sandwich.price property.

---

## 9. Deliverables
- Updated Cart model methods and tests.
- CartScreen UI implementing inline controls, dialogs, edit modal, remove + undo.
- Unit and widget tests covering acceptance criteria.
- README note describing undo behavior and max quantity.
