db.items.drop();
db.createCollection('items');
db.items.ensureIndex({text:1},{unique:true,sparse:true});
