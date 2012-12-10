#The bug

model.set doesn't fire its callback after a certain situation:
- insert a "row" which fails - the transaction must fail somehow (duplicate key).
- after that when inserrting a row that should go ok, the callback won't be fired.
- the row is inserted anyway, but the problem is that the callback wasn't fired.

Create the database with the following command:
`mongo derbytest4 db.js`

#To reproduce the bug

Run the app, insert some lines of text. Insert the same text twice, when a failed transaction will occur. After that you should see the problem when inserting another new line (which doesn'tr exist in the database).