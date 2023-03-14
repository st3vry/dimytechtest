
## Test Backend Dimy

for testing purpose only

```
npx sequelize-cli db:migrate 
npx sequelize-cli db:seed

node server.js
```

transactions testing:
```
/api/transactions/

post data:
address_id : address_id
products : [{id:product_id}] // more than one value allowed
payment_methods : [{id:payment_method_id}] // more than one value allowed

```