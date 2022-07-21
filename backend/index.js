const express = require("express");
const app = express();
const port = process.env.PORT || 8080;

const { newInvestmentContract, deposit, claim, linkZAR, getPoolValue } = require('./api.js');

app.use(express.json())

app.listen(
    port,
    () => console.log(`it's alive on http://localhost:${port}`)
);

app.post('/create_investment', async (req, res) =>  {

    var address = await newInvestmentContract(req.body.uri, req.body.target, req.body.interest);

    if (address != undefined) {
        res.status(200).send({
            pool: address,
        })
    } else { 
        res.status(400).send("Error creating new investment contract")
    }

});

app.post('/deposit', async (req, res) => {

    var key = "";
    var deposit = await deposit(req.body.amount, key);

    if (deposit) {
        res.status(200).send({
            trasaction_status: "Success.",

        })
    } else {
        res.status(400).send({
            trasaction_status: "Failed.",
        })
    }
});

app.post('/claim', async (req, res) => {
    var claim = await claim(req.body.address, req.body.key);

    if (claim) {
        res.status(200).send({
            trasaction_status: "Success.",

        })
    } else {
        res.status(400).send({
            trasaction_status: "Failed.",
        })
    }
});

app.post('/fulfill_investment', async (req, res) => {
    var fulfilled = await setFulfilled(req.body.key);

    if (fulfilled) {
        res.status(200).send({
            trasaction_status: "Success.",

        })
    } else {
        res.status(400).send({
            trasaction_status: "Failed.",
        })
    }
});

