<script>
export default {
  data() {
    return {
        products:
            [
                {
                    "name":"Product 1",
                    "price":15000,
                    "qty":2,
                }
            ]
        }
    },
    methods: {
        addRow() {{
            this.products.push(
                {
                    "name":"",
                    "price":0,
                    "qty":1,
                }
            )
        }},
        deleteRow(index) {
            this.products.splice(index,1)
        },
        sumTotal(index) {
            console.log(this.products[index].qty * this.products[index].price)
        }
    }
}
</script>

<template>
    <div class="greetings">
        <button title="New Row" class="btn btn-secondary" v-on:click="addRow()">NEW</button>
        <table class="table table-hover table-striped table-dark w-100">
        <tr v-for="(product, index) in products" :key="product">
            <td>
                <label>Product name</label>
                <input type="text" class="form-control groupName" v-model="product.name">
            </td> 
            <td>
                <label>Product price</label>
                <input type="number" class="form-control" v-model="product.price">
            </td> 
            <td>
                <label>Qty</label>
                <input type="number" class="form-control" v-model="product.qty">
            </td> 
            <td>
                <label>Total</label>
                <input type="number" class="form-control" :value="product.qty*product.price">
            </td> 
            <td style="min-width: 80px; padding: 0;">
                <button v-if="index!==0" v-on:click="deleteRow(index)" style="vertical-align:bottom;" class="btn btn-danger"> Delete </button> 
            </td>  
        </tr> 
        <tr>
            <td colspan="3"></td>
            <td>
                <label>Grand Total</label>
                <input type="number" disabled class="form-control" :value="Object.values(products).reduce((grandTotal, product) => product.qty*product.price + grandTotal,0)">
            </td>
        </tr>
    </table>
    </div>
    
</template>

<style scoped>
h1 {
  font-weight: 500;
  font-size: 2.6rem;
  top: -10px;
}

h3 {
  font-size: 1.2rem;
}

.greetings h1,
.greetings h3 {
  text-align: center;
}
label {
    font-weight: bold;
    display: inline-block;
    margin-bottom: .5rem;
}
.form-control {
    display: block;
    width: 100%;
    padding: .375rem .75rem;
    font-size: 1rem;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: .25rem;
    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}
.btn {
    display: inline-block;
    font-weight: 400;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    border: 1px solid transparent;
    margin:0 12px;
    padding: .375rem .75rem;
    font-size: 1rem;
    line-height: 1.5;
    border-radius: .25rem;
    transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}

.btn:focus, .btn:hover {
    text-decoration: none;
}

.btn:not(:disabled):not(.disabled) {
    cursor: pointer;
}
.btn-secondary {
    color: #fff;
    background-color: #6c757d;
    border-color: #6c757d;
}
.btn-secondary:hover {
    color: #fff;
    background-color: #5a6268;
    border-color: #545b62;
}
.btn-danger {
    color: #fff;
    background-color: #dc3545;
    border-color: #dc3545;
}
.btn-danger:hover {
    color: #fff;
    background-color: #bf2b3a;
    border-color: #bf2b3a;
}

table {
    border-collapse: collapse;
    min-width: 80vh;
}
.table {
    width: 100%;
    max-width: 100%;
    margin-bottom: 1rem;
    background-color: transparent;
}
.table td{
    padding: 12px;
}



@media (min-width: 1024px) {
  .greetings h1,
  .greetings h3 {
    text-align: left;
  }
}
</style>
