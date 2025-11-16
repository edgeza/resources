window.addEventListener("message", function (event) {
    var item = event.data;
    app.translate(item.translate)
    switch (item.action) {
      case "open":
        app.setupBilling(item.player, item.bills, item.jobBills, item.closestPlayers, item.isAuth, item.isCompany)
        break;
      case "invoiceData":
        app.fillJobInvoices(item.jobBills)
        app.requestInvoice(item.invoiceData)
        break;
      case "close":
        break;
      case "pos":
        app.openPos(item.player, item.closestPlayers);
        break;
      case "syncpos":
        app.syncPos(item.amount, item.sender, item.senderJob);
        break;
      case "admin":
        app.openAdmin(item.player, item.bills);
        break;
    }
});

const app = new Vue({
    el: '#app',
    data: {
        billing: {
            enabled: false,
            adminenabled: false,
            isAuth: false,
            isCompany: false,
            info: {
                invoices: "Invoices",
                myInvoices: "My Invoices",
                referance: "Referance",
                citizen: "Citizen",
                createInvoice: "Create Invoice",
                search: "Search",
                pressEnter: "Press enter to search",
                cityInvoices: "City Invoices",
                paid: "Paid",
                unpaid: "Unpaid",
                show: "Show",
                referances: "Referance",
                status: "Status",
                owner: "Owner",
                amount: "Amount",
                accept: "Accept",
                actions: "Actions",
                date: "Date",
                billto: "Bill To",
                wat: "Wat",
                name: "Name",
                totalDebt: "Total Debt",
                invoicesTitle: "Invoices Title",
                total: "Total",
                price: "Price",
                create: "Create",
                invoiceType: "Invoice Type",
                personel: "Personel",
                company: "Company",
                select: "Select",
                selected: "Selected",
                send: "Send",
                mandatory: "Is it mandatory?",
                description: "Description",
                paytocard: "Pay to Card",
                paytocash: "Pay to Cash",
                bankName: "Bank Name",
                bankDescription: "Bank Description",
                enterverificationcode: "Enter Verification Code",
                verificationDescription: "We have sent a verification code to your phone number",
                confirm: "Confirm",
                cancel: "Cancel",
                pay: "Pay",
                delete: "Delete",
                paymentSuccess: "Payment Success",
                paymentSuccessDescription: "Your payment has been successfully completed.",
                paymentError: "Payment Error",
                paymentErrorDescription: "Your payment has been canceled.",
                transferCode: "Transfer Code Here!",
                transferCodeDescription: "Enter the transfer code you received from the bank.",
                selectUser: "Select User",
                selectUserDescription: "Select the user you want to send the invoice to.",
                couldntFound: "Couldnt found anyone with this name",
            },
            router: "invoices",
            referanceLength: 10,
            verifyCodeLength: 5,
            searchInvoices: "",
            searchMyInvoices: "",
            serachReferance: "",
            searchCitizen: "",
            searchAdmin: "",
            invoicesDetail: false,
            wat: 10, // max 100
            invoicesInfo: {
                title: "",
                date: "",
                amount: "",
                status: "",
                owner: "",
                billto: "",
                type: "",
                referance: "",
                description: "",
                button: "",
            },
            player1: {
                name: "",
                citizen: "",
                job: "",
            },
            citizenInfo: {
                name: "",
                totalDebt: "",
            },
            newInvoiceForm: {
                title: "",
                amount: "",
                description: "",
                mandatory: false,
                type: "personel",
            },
            invoicesRequest: {
                enabled: false,
                title: "Test Dusa 1",
                amount: 35914,
                description: "Lormmmmm",
                owner: "Mark Jess",
                ownercitizen: "ASDA",
                billto: "Ali Göt",
                tocitizen: "ASD64AS",
                date: "2024-01-06",
                jobName: "mechanic",
                reference: "546ASDASD",
            },
            // Oyuncunun ödeyeceği faturalar
            invoices: [
                { title: "Invoice 1", date: "2024-01-06", amount: 8500, status: "paid", owner: "John Doe", ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Company", referance: "V1I84DNQ09", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 2", date: "2024-01-06", amount: 2300, status: "unpaid", owner: "John Doe", ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Personel", referance: "FCLG6SIVKH", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 3", date: "2024-01-06", amount: 12300, status: "paid", owner: "John Doe", ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Company", referance: "90UD21GK8B", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 4", date: "2024-01-06", amount: 4100, status: "unpaid", owner: "John Doe", ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Personel", referance: "1Q5J27VGIS", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 5", date: "2024-01-06", amount: 100, status: "paid", owner: "John Doe", ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Company", referance: "HGET765H55", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 6", date: "2024-01-06", amount: 3300, status: "unpaid", owner: "John Doe", ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Personel", referance: "IJRMSM3SOM", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 7", date: "2024-01-06", amount: 6351, status: "paid", owner: "John Doe", ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Company", referance: "XI71B1M17Y", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 8", date: "2024-01-06", amount: 911, status: "unpaid", owner: "John Doe", ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Personel", referance: "Q24VM4XZ2N", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
            ],
            myInvoices: [
                { title: "Invoice 1", date: "2024-01-06", amount: 8500, status: "paid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Company", referance: "V1I84DNQ09", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 2", date: "2024-01-06", amount: 2300, status: "unpaid", owner: "John Doe", ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Personel", referance: "FCLG6SIVKH", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 3", date: "2024-01-06", amount: 12300, status: "paid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Company", referance: "90UD21GK8B", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 4", date: "2024-01-06", amount: 4100, status: "unpaid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"",type: "Personel", referance: "1Q5J27VGIS", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 5", date: "2024-01-06", amount: 100, status: "paid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Company", referance: "HGET765H55", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 6", date: "2024-01-06", amount: 3300, status: "unpaid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Personel", referance: "IJRMSM3SOM", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 7", date: "2024-01-06", amount: 6351, status: "paid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Company", referance: "XI71B1M17Y", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 8", date: "2024-01-06", amount: 911, status: "unpaid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Personel", referance: "Q24VM4XZ2N", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
            ],
            cityInvoices: [
                { title: "Invoice 1", date: "2024-01-06", amount: 8500, status: "paid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Company", referance: "V1I84DNQ09", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 2", date: "2024-01-06", amount: 2300, status: "unpaid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Personel", referance: "FCLG6SIVKH", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 3", date: "2024-01-06", amount: 12300, status: "paid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Company", referance: "90UD21GK8B", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 4", date: "2024-01-06", amount: 4100, status: "unpaid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Personel", referance: "1Q5J27VGIS", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 5", date: "2024-01-06", amount: 100, status: "paid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Company", referance: "HGET765H55", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 6", date: "2024-01-06", amount: 3300, status: "unpaid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Personel", referance: "IJRMSM3SOM", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 7", date: "2024-01-06", amount: 6351, status: "paid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Company", referance: "XI71B1M17Y", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 8", date: "2024-01-06", amount: 911, status: "unpaid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Personel", referance: "Q24SM4XZ2N", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 9", date: "2024-01-06", amount: 213412, status: "paid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Personel", referance: "U32AM4XZ2N", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 10", date: "2024-01-06", amount: 145, status: "unpaid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Company", referance: "Q24VM4XZ2N", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 11", date: "2024-01-06", amount: 2135123, status: "paid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Personel", referance: "73ZAM4XZ2N", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
                { title: "Invoice 12", date: "2024-01-06", amount: 1412344, status: "unpaid", owner: "John Doe",  ownerCitizen:"", billto: "Mark Jess", toCitizen:"", type: "Company", referance: "T14VN4XZ2N", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum." },
            ],
            twoFactor: {
                enabled: false,
                referance: "",
                verifyCode: "",
                code: "",
                type: "verify"
            },
            userList: false,
            userLists: [
                { name: "Test Dusa 1", citizen: "GCQ40392", selected: false },
                { name: "Test Dusa 2", citizen: "GCQ40392", selected: false },
                { name: "Test Dusa 3", citizen: "GCQ40392", selected: false },
                { name: "Test Dusa 4", citizen: "GCQ40392", selected: false },
                { name: "Test Dusa 5", citizen: "GCQ40392", selected: false },
                { name: "Test Dusa 6", citizen: "GCQ40392", selected: false },
                { name: "Test Dusa 7", citizen: "GCQ40392", selected: false },
                { name: "Test Dusa 8", citizen: "GCQ40392", selected: false },
                { name: "Test Dusa 1", citizen: "GCQ40392", selected: false },
                { name: "Test Dusa 2", citizen: "GCQ40392", selected: false },
                { name: "Test Dusa 3", citizen: "GCQ40392", selected: false },
                { name: "Test Dusa 4", citizen: "GCQ40392", selected: false },
                { name: "Test Dusa 5", citizen: "GCQ40392", selected: false },
                { name: "Test Dusa 6", citizen: "GCQ40392", selected: false },
                { name: "Test Dusa 7", citizen: "GCQ40392", selected: false },
                { name: "Test Dusa 8", citizen: "GCQ40392", selected: false },
            ],
            jobImage: [
                { name: "ambulance", image: "https://media.discordapp.net/attachments/1143528082913906688/1193632716617416846/Rectangle_13.png?ex=65ad6c18&is=659af718&hm=6687185cd08e20decfa93d55ceb53e732cb49a2f61bfd435ec2639617dd523f2&=&format=webp&quality=lossless" },
                { name: "mechanic", image: "https://media.discordapp.net/attachments/1143528082913906688/1193632716160249966/image_2.png?ex=65ad6c18&is=659af718&hm=6c0aa31ea7f6a2663e7b01a765a7fa7860964403e31f81e12dcf049437b6aa5f&=&format=webp&quality=lossless" },
            ]
        },
        posMachine: {
            enabled: false,
            info:{
                enterAmount: "Enter Amount",
                pay: "Pay",
                payDescription: "Please scan your card.",
                paymentSuccess: "Payment Success",
                paymentSuccessDescription: "Your payment has been successfully completed.",
                paymentError: "Payment Error",
                paymentErrorDescription: "Your payment has been canceled.",
            },
            posInput: "",
            type:"input",
            userList:[
                {name:"Test Dusa 1", id:"1", citizen:"GCQ40392", selected:false},
                {name:"Test Dusa 2", id:"2", citizen:"GCQ40392", selected:false},
                {name:"Test Dusa 3", id:"3", citizen:"GCQ40392", selected:false},
                {name:"Test Dusa 4", id:"4", citizen:"GCQ40392", selected:false},
                {name:"Test Dusa 5", id:"5", citizen:"GCQ40392", selected:false},
                {name:"Test Dusa 6", id:"6", citizen:"GCQ40392", selected:false},
            ]
        },
    },
    mounted() {
    },
    methods: {
        createReference() {
            let result = '';
            const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
            const charactersLength = characters.length;
            let counter = 0;
            while (counter < this.billing.referanceLength) {
                result += characters.charAt(Math.floor(Math.random() * charactersLength));
                counter += 1;
            }
            return result;
        },
        createVerifyCode() {
            let result = '';
            const characters = '0123456789';
            const charactersLength = characters.length;
            let counter = 0;
            while (counter < this.billing.verifyCodeLength) {
                result += characters.charAt(Math.floor(Math.random() * charactersLength));
                counter += 1;
            }
            return result;
        },
        screenShot() {
            html2canvas(document.querySelector('.invoices-detail-inner'), {
                onrendered: function (canvas) {
                    // document.body.appendChild(canvas);
                    return Canvas2Image.saveAsPNG(canvas);
                }
            });
        },
        showDetail(item, type) {
            this.billing.invoicesDetail = true;
            this.billing.invoicesInfo = item;
            this.billing.invoicesInfo.button = type;
        },
        cancelInvoices() {
            this.clearForm();
        },
        closeDetail(e) {
            if (e.target.classList.contains('invoices-detail')) {
                this.billing.invoicesDetail = false;
            }
        },
        payToCash(referance) {
            let index = this.billing.invoices.findIndex(item => item.referance == referance);
            let index2 = this.billing.myInvoices.findIndex(item => item.referance == referance);
            let index3 = this.billing.cityInvoices.findIndex(item => item.referance == referance);
            // fetch cash
            fetch("https://dusa_billing/checkMoney", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json; charset=UTF-8",
                },
                body: JSON.stringify({
                    type: "cash",
                    amount: this.getTotalPrice(this.billing.cityInvoices[index3].amount, this.billing.wat)
                }),
            }).then(resp => resp.json())
            .then(data => {
                if (data !== false) {
                    if (index != -1) {
                        this.billing.invoices[index].status = "paid";
                    } if (index2 != -1) {
                        this.billing.myInvoices[index2].status = "paid";
                    } if (index3 != -1) {
                        this.billing.cityInvoices[index3].status = "paid";
                    }
                    this.post('payInvoice', {type: "cash", reference: this.billing.cityInvoices[index3].referance, amount: this.getTotalPrice(this.billing.cityInvoices[index3].amount, this.billing.wat), owner: this.billing.cityInvoices[index3].ownerCitizen, company: this.billing.cityInvoices[index3].type, job: this.billing.cityInvoices[index3].ownerJob})
                } else {
                }
            })
            .catch(error => console.error('Error:', error));
            
        },
        confirmVerify() {
            if (this.billing.twoFactor.code == this.billing.twoFactor.verifyCode) {
                this.billing.twoFactor.type = "success";
                let index = this.billing.invoices.findIndex(item => item.referance == this.billing.twoFactor.referance);
                let index2 = this.billing.myInvoices.findIndex(item => item.referance == this.billing.twoFactor.referance);
                let index3 = this.billing.cityInvoices.findIndex(item => item.referance == this.billing.twoFactor.referance);
                // fetch bank
                fetch("https://dusa_billing/checkMoney", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json; charset=UTF-8",
                    },
                    body: JSON.stringify({
                        type: "card",
                        amount: this.getTotalPrice(this.billing.invoicesInfo.amount, this.billing.wat)
                    }),
                }).then(resp => resp.json())
                .then(data => {
                    if (data !== false) {
                        if (index != -1) {
                            this.billing.invoices[index].status = "paid";
                        } if (index2 != -1) {
                            this.billing.myInvoices[index2].status = "paid";
                        } if (index3 != -1) {
                            this.billing.cityInvoices[index3].status = "paid";
                        }
                        this.billing.twoFactor.code = "";
                        setTimeout(() => {
                            this.billing.twoFactor.enabled = false;
                            this.billing.twoFactor.type = "verify";
                            this.post('payInvoice', {type: "card", reference: this.billing.invoices[index].referance, amount: this.getTotalPrice(this.billing.invoices[index].amount, this.billing.wat), owner: this.billing.invoices[index].ownerCitizen, company: this.billing.invoices[index].type, job: this.billing.invoices[index].ownerJob})
                        }, 3500);
                    } else {
                        console.log('data false', data)
                    }
                })
                .catch(error => console.error('Error:', error));
            }
            else {
                this.billing.twoFactor.type = "error";
                this.billing.twoFactor.code = "";
                setTimeout(() => {
                    this.billing.twoFactor.enabled = false;
                    this.billing.twoFactor.type = "verify";
                }, 3500);
            }
        },
        cancelVerify() {
            this.billing.twoFactor.enabled = false;
            this.billing.twoFactor.type = "verify";
            this.billing.twoFactor.code = "";
        },
        payToCard(referance) {
            this.billing.twoFactor.enabled = true;
            this.billing.twoFactor.referance = referance;
            this.billing.twoFactor.verifyCode = this.createVerifyCode();
            this.sendCode();
        },
        sendCode() {
            let div = document.querySelector('.two-factor-notify');
            let message = `
                <img src="assets/img/visa.png" alt="ss">
                <h2> ${this.billing.info.transferCode} </h2>
                <p> ${this.billing.info.transferCodeDescription} <b> "${this.billing.twoFactor.verifyCode}" </b> </p>`
            let newMessage = document.createElement('div');
            newMessage.classList.add('two-factor-message');
            newMessage.innerHTML = message;
            gsap.set(newMessage, { x: "110%" })
            div.appendChild(newMessage);
            gsap.to(newMessage, { duration: 1, x: "-10%", ease: "power2.inOut" });
            setTimeout(() => {
                gsap.to(newMessage, { duration: 1, x: "110%", ease: "power2.inOut" });
                setTimeout(() => {
                    div.removeChild(newMessage);
                }, 1200);
            }, 8000);
        },
        getTotalPrice(amount, wat) {
            return Number(amount) + Math.floor((amount / wat));
        },
        searchCitizen() {
            if (this.billing.searchCitizen == "") {
                return;
            }
            fetch("https://dusa_billing/getDebt", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json; charset=UTF-8",
                },
                body: JSON.stringify({
                    name: this.billing.searchCitizen
                }),
            }).then(resp => resp.json())
            .then(data => {
                if (data == false) { this.post('notify', {text: this.billing.info.couldntFound, type: 'error'}); return; }
                this.billing.citizenInfo.name = this.billing.searchCitizen;
                this.billing.citizenInfo.totalDebt = data;
            })
            .catch(error => console.error('Error:', error));
        },
        userSelect(item) {
            this.billing.userLists.forEach(item => {
                item.selected = false;
            });
            item.selected = !item.selected;
        },
        createInvoices() {
            let user = this.billing.userLists.find(item => item.selected == true);
            let newInvoice = {
                title: this.billing.newInvoiceForm.title,
                date: this.getDate,
                amount: this.billing.newInvoiceForm.amount,
                status: "unpaid",
                billFrom: {
                    name: this.billing.player1.name,
                    citizen: this.billing.player1.citizen,
                    job: this.billing.player1.job
                },
                billTo: {
                    name: user.name,
                    citizen: user.citizen,
                },
                type: this.billing.newInvoiceForm.type,
                referance: this.createReference(),
                description: this.billing.newInvoiceForm.description,
                mandatory: this.billing.newInvoiceForm.mandatory,
                job: (this.billing.newInvoiceForm.type === "company") ? this.billing.player1.job : "",
            }
            if (newInvoice.mandatory) { // Zorunluysa sormadan keser
                this.post('createInvoice', newInvoice);
                this.billing.invoices.push(newInvoice); // Kesilen Kişi
                this.billing.myInvoices.push(newInvoice); //Kesen Kişi
                this.billing.cityInvoices.push(newInvoice); // Şehir
            } else { // Zorunlu değilse yakındaki oyuncuya ekran çıkarır
                this.post('requestInvoice', newInvoice);
                this.post('closeNUI');
                this.billing.enabled = false;
            }
            this.clearForm();
        },
        clearForm() {
            this.billing.newInvoiceForm.title = "";
            this.billing.newInvoiceForm.amount = "";
            this.billing.newInvoiceForm.description = "";
            this.billing.newInvoiceForm.compulsory = false;
            this.billing.newInvoiceForm.type = "personel";

            this.billing.userLists.forEach(item => {
                item.selected = false;
            });
            this.billing.userList = false;
        },
        requestInvoice(data) {
            this.billing.enabled = false;
            this.billing.invoicesRequest.enabled = true;
            this.billing.invoicesRequest.title = data.title;
            this.billing.invoicesRequest.amount = data.amount;
            this.billing.invoicesRequest.description = data.description;
            this.billing.invoicesRequest.owner = data.billFrom.name;
            this.billing.invoicesRequest.ownercitizen = data.billFrom.citizen;
            this.billing.invoicesRequest.ownerjob = data.billFrom.job;
            this.billing.invoicesRequest.billto = data.billTo.name;
            this.billing.invoicesRequest.tocitizen = data.billTo.citizen;
            this.billing.invoicesRequest.date = data.date;
            this.billing.invoicesRequest.jobName = data.job;
            this.billing.invoicesRequest.reference = data.referance;
            this.billing.invoicesRequest.type = data.type;
        },
        getJobImage() {
            let name = this.billing.invoicesRequest.jobName;
            let image = this.billing.jobImage.find(item => item.name == name);
            if (image) {
                return image.image;
            }
            else {
                return "";
            }
        },
        acceptRequest() {
            let newInvoice = {
                title: this.billing.invoicesRequest.title,
                date: this.billing.invoicesRequest.date,
                amount: this.billing.invoicesRequest.amount,
                status: "unpaid",
                billFrom: {
                    name: this.billing.invoicesRequest.owner,
                    citizen: this.billing.invoicesRequest.ownercitizen,
                    job: this.billing.invoicesRequest.ownerjob,
                },
                billTo: {
                    name: this.billing.invoicesRequest.billto,
                    citizen: this.billing.invoicesRequest.tocitizen,
                },
                type: this.billing.invoicesRequest.type,
                referance: this.billing.invoicesRequest.reference,
                description: this.billing.invoicesRequest.description,
            }
            this.billing.invoicesRequest.enabled = false;
            this.post('createInvoice', newInvoice);
            this.billing.invoices.push(newInvoice); // Kesilen Kişi
            this.billing.myInvoices.push(newInvoice); //Kesen Kişi
            this.billing.cityInvoices.push(newInvoice); // Şehir
            this.post('closeNUI')
        },
        cancelRequest() {
            this.billing.invoicesRequest.enabled = false
            this.post('closeNUI')
        },
        openAdmin(player, bills) {
            this.billing.adminenabled = true;
            this.billing.invoices = []; // billto citizen == player.citizen
            this.billing.myInvoices = []; // owner citizen == player.citizen
            this.billing.cityInvoices = [];
            this.fillInvoices(player, bills);
        },
        payAdmin(referance){
            let index = this.billing.invoices.findIndex(item => item.referance == referance);
            let index2 = this.billing.myInvoices.findIndex(item => item.referance == referance);
            let index3 = this.billing.cityInvoices.findIndex(item => item.referance == referance);
            if (index != -1) {
                this.billing.invoices[index].status = "paid";
            } 
            if (index2 != -1) {
                this.billing.myInvoices[index2].status = "paid";
            } 
            if (index3 != -1) {
                this.billing.cityInvoices[index3].status = "paid";
            }
            this.post('payInvoice', referance)
        },
        deleteAdmin(referance){
            let index = this.billing.invoices.findIndex(item => item.referance == referance);
            let index2 = this.billing.myInvoices.findIndex(item => item.referance == referance);
            let index3 = this.billing.cityInvoices.findIndex(item => item.referance == referance);
            if (index != -1) {
                this.billing.invoices.splice(index,1);
            }
            if (index2 != -1) {
                this.billing.myInvoices.splice(index2,1);
            } 
            if (index3 != -1) {
                this.billing.cityInvoices.splice(index3,1);
            }
            this.post('deleteInvoice', referance)
        },
        setupBilling(player, bills, jobBills, closestPlayers, isAuth, isCompany) {
            this.billing.enabled = true;
            this.billing.player1.name = player.name;
            this.billing.player1.citizen = player.citizen;
            this.billing.player1.job = player.job;
            this.billing.invoices = []; // billto citizen == player.citizen
            this.billing.myInvoices = []; // owner citizen == player.citizen
            this.billing.cityInvoices = [];
            this.billing.jobImage = [];
            this.billing.userLists = [];
            this.posMachine.userList = [];
            this.fillInvoices(player, bills);
            this.fillJobInvoices(jobBills);
            this.fillClosestPlayers(closestPlayers);
            this.billing.isAuth = isAuth;
            this.billing.isCompany = isCompany;
        },
        fillInvoices(player, bills) {
            if (typeof bills !== 'undefined' && bills !== null && bills !== "empty") {
                    bills.forEach(e => {
                        if(JSON.parse(e.billTo).citizen == player.citizen) {
                            this.billing.invoices.push({
                                title: e.title,
                                date: e.date,
                                amount: e.amount,
                                status: e.status,
                                owner: JSON.parse(e.billFrom).name,
                                ownerCitizen: JSON.parse(e.billFrom).citizen,
                                ownerJob: JSON.parse(e.billFrom).job,
                                billto: JSON.parse(e.billTo).name,
                                toCitizen: JSON.parse(e.billTo).citizen,
                                type: e.type,
                                referance: e.reference,
                                description: e.description,
                            })
                        }
                        if(JSON.parse(e.billFrom).citizen == player.citizen) {
                            this.billing.myInvoices.push({
                                title: e.title,
                                date: e.date,
                                amount: e.amount,
                                status: e.status,
                                owner: JSON.parse(e.billFrom).name,
                                ownerCitizen: JSON.parse(e.billFrom).citizen,
                                ownerJob: JSON.parse(e.billFrom).job,
                                billto: JSON.parse(e.billTo).name,
                                toCitizen: JSON.parse(e.billTo).citizen,
                                type: e.type,
                                referance: e.reference,
                                description: e.description,
                            })
                        }
                        this.billing.cityInvoices.push({
                            title: e.title,
                            date: e.date,
                            amount: e.amount,
                            status: e.status,
                            owner: JSON.parse(e.billFrom).name,
                            ownerCitizen: JSON.parse(e.billFrom).citizen,
                            ownerJob: JSON.parse(e.billFrom).job,
                            billto: JSON.parse(e.billTo).name,
                            toCitizen: JSON.parse(e.billTo).citizen,
                            type: e.type,
                            referance: e.reference,
                            description: e.description,
                        })
                    })
            }
        },
        fillJobInvoices(jobBills) {
            this.billing.jobImage = [];
            jobBills.forEach(e => {
                this.billing.jobImage.push({
                    name: e.name,
                    image: e.image
                })
            })
        },
        fillClosestPlayers(closestPlayers) {
            closestPlayers.forEach(e => {
                this.billing.userLists.push({
                    name: e.name,
                    citizen: e.citizen,
                    selected: false,
                })
                this.posMachine.userList.push({
                    name: e.name,
                    citizen: e.citizen,
                    id: e.id,
                    selected: false,
                })
            })
        },
        openPos(player, closestPlayers) {
            this.posMachine.enabled = true;
            this.posMachine.userList = [];
            if (closestPlayers) {
                this.fillClosestPlayers(closestPlayers);
            }
            if (player) {
                this.billing.player1.name = player.name;
                this.billing.player1.citizen = player.citizen;
                this.billing.player1.job = player.job;
            }
        },
        // posbutton player 1'de çalışır
        posButton(number){
            if(this.posMachine.type == "pay"){
                return;
            }
            if(number == "delete"){
                this.posMachine.posInput = this.posMachine.posInput.slice(0,-1);
                return;
            }
            if(number == "close"){
                this.posMachine.posInput = "";
                this.posMachine.type = "input";
                this.posMachine.enabled = false;
                this.post('closeNUI')
                return;
            }
            if(number == "enter"){
                if(Number(this.posMachine.posInput) > 0){
                    this.posMachine.type = "selectUser";

                    // Buraya ödenecek tutarı yazdırdım
                    if  (this.posUserCheck()) {
                        // Buraya ödeyecek kişiyi yazdırdım
                        let user = this.posMachine.userList.find(item => item.selected == true);
                        
                        setTimeout(() => {
                            // Ödeme başarılı ise "success" değilse "error" yazdır
                            this.post('openPosAtTarget', {player: user.citizen, input: Number(this.posMachine.posInput), sentBy: this.billing.player1.citizen, senderJob: this.billing.player1.job})
                            this.posMachine.type = "success";
                            this.posMachine.enabled = false;
                            this.posMachine.type = "input";
                            this.post('closeNUI')
                            this.posMachine.posInput = "";
                        }, 300);
                    }
                } else{
                    return;
                }
                return;
            }
            if(number !== "0"){
                this.posMachine.posInput += number;
            } else if(this.posMachine.posInput !== ""){
                this.posMachine.posInput += number;
            }
        },
        // syncpos hedef oyuncuda çalışır
        syncPos(amount, sender, senderJob) {
            this.openPos();
            this.posMachine.type = "pay";
            this.posMachine.posInput = amount;
            money = this.posMachine.posInput;
            // Buraya ödenecek tutarı yazdırdım
            let card = document.querySelector('.pos-card');
            let reader = document.querySelector('.pos-input');
            window.addEventListener('mousemove', (e) => {
                let x = e.clientX - 100;
                let y = e.clientY - 100;
                card.style.left = x + "px";
                card.style.top = y + "px";
            });
            reader.addEventListener('mouseenter', () => {
                setTimeout(() => {
                    // Ödeme başarılı ise "success" değilse "error" yazdır
                    if (this.posMachine.posInput !== "") {
                        fetch("https://dusa_billing/checkMoney", {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/json; charset=UTF-8",
                            },
                            body: JSON.stringify({
                                type: "card",
                                amount: money
                            }),
                        }).then(resp => resp.json())
                        .then(data => {
                            if (data !== false) {
                                this.posMachine.type = "success";
                                this.post('payImmediately', {amount: money, sentBy: sender, senderJob: senderJob})
                                this.posMachine.enabled = false;
                                this.posMachine.type = "input";
                                this.posMachine.posInput = "";
                                money = undefined;
                                this.post('closeNUI')
                                return
                            } else {
                                this.posMachine.type = "error";
                                this.posMachine.enabled = false;
                                this.posMachine.type = "input";
                                this.posMachine.posInput = "";
                                money = undefined;
                                this.post('closeNUI')
                                return
                            }
                        })
                        .catch(error => console.error('Error:', error));
                    }

                    reader.removeEventListener('mouseenter', () => {
                    });
                    window.removeEventListener('mousemove', () => {       
                    });
                }, 1000);
            });
        },
        posUserSelect(item){
            this.posMachine.userList.forEach(item => {
                item.selected = false;
            });
            item.selected = !item.selected;
        },
        posUserCheck(){
            let check = false;
            this.posMachine.userList.forEach(item => {
                if(item.selected){
                    check = true;
                }
            });
            return check;
        },
        close() {
            this.billing.enabled = false;
            this.billing.twoFactor.enabled = false;
            this.billing.invoicesRequest.enabled = false;
            this.posMachine.enabled = false;
            this.posMachine.type = "input";
            this.billing.adminenabled = false;
        },
        translate(e) {
            this.billing.info.invoices = e.invoices
            this.billing.info.myInvoices = e.myInvoices
            this.billing.info.referance = e.referance
            this.billing.info.citizen = e.citizen
            this.billing.info.createInvoice = e.createInvoice
            this.billing.info.search = e.search
            this.billing.info.pressEnter = e.pressEnter
            this.billing.info.cityInvoices = e.cityInvoices
            this.billing.info.paid = e.paid
            this.billing.info.unpaid = e.unpaid
            this.billing.info.show = e.show
            this.billing.info.referances = e.referances
            this.billing.info.status = e.status
            this.billing.info.owner = e.owner
            this.billing.info.amount = e.amount
            this.billing.info.accept = e.accept
            this.billing.info.actions = e.actions
            this.billing.info.date = e.date
            this.billing.info.billto = e.billto
            this.billing.info.wat = e.wat
            this.billing.info.name = e.name
            this.billing.info.totalDebt = e.totalDebt
            this.billing.info.invoicesTitle = e.invoicesTitle
            this.billing.info.total = e.total
            this.billing.info.price = e.price
            this.billing.info.create = e.create
            this.billing.info.invoiceType = e.invoiceType
            this.billing.info.personel = e.personel
            this.billing.info.company = e.company
            this.billing.info.select = e.select
            this.billing.info.selected = e.selected
            this.billing.info.send = e.send
            this.billing.info.mandatory = e.mandatory
            this.billing.info.description = e.description
            this.billing.info.paytocard = e.paytocard
            this.billing.info.paytocash = e.paytocash
            this.billing.info.bankName = e.bankName
            this.billing.info.bankDescription = e.bankDescription
            this.billing.info.enterverificationcode = e.enterverificationcode
            this.billing.info.verificationDescription = e.verificationDescription
            this.billing.info.confirm = e.confirm
            this.billing.info.cancel = e.cancel
            this.billing.info.pay = e.pay
            this.billing.info.delete = e.delete
            this.billing.info.paymentSuccess = e.paymentSuccess
            this.billing.info.paymentSuccessDescription = e.paymentSuccessDescription
            this.billing.info.paymentError = e.paymentError
            this.billing.info.paymentErrorDescription = e.paymentErrorDescription
            this.billing.info.transferCode = e.transferCode
            this.billing.info.transferCodeDescription = e.transferCodeDescription
            this.billing.info.selectUser = e.selectUser
            this.billing.info.selectUserDescription = e.selectUserDescription
            this.billing.info.couldntFound = e.couldntFound
            this.posMachine.info.enterAmount = e.enterAmount
            this.posMachine.info.pay = e.pay
            this.posMachine.info.payDescription = e.payDescription
            this.posMachine.info.paymentSuccess = e.paymentSuccess
            this.posMachine.info.paymentSuccessDescription = e.paymentSuccessDescription
            this.posMachine.info.paymentError = e.paymentError
            this.posMachine.info.paymentErrorDescription = e.paymentErrorDescription
        },
        post: function (event, data) {
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "https://dusa_billing/" + event);
            xhr.setRequestHeader("Content-Type", "application/json");
            xhr.onreadystatechange = function () {
              if (xhr.readyState === 4 && xhr.status === 200) {
              }
            };
            xhr.send(JSON.stringify({ data }));
        },

    },
    computed: {
        filteredInvoices: function () {
            return this.billing.invoices.filter(item => {
                return item.title.toLowerCase().includes(this.billing.searchInvoices.toLowerCase()) ||
                    item.owner.toLowerCase().includes(this.billing.searchInvoices.toLowerCase()) ||
                    item.billto.toLowerCase().includes(this.billing.searchInvoices.toLowerCase()) ||
                    item.type.toLowerCase().includes(this.billing.searchInvoices.toLowerCase()) ||
                    item.referance.toLowerCase().includes(this.billing.searchInvoices.toLowerCase()) ||
                    item.description.toLowerCase().includes(this.billing.searchInvoices.toLowerCase()) ||
                    item.amount.toString().toLowerCase().includes(this.billing.searchInvoices.toLowerCase()) ||
                    item.date.toLowerCase().includes(this.billing.searchInvoices.toLowerCase());
            });
        },
        filteredMyInvoices: function () {
            return this.billing.myInvoices.filter(item => {
                return item.title.toLowerCase().includes(this.billing.searchMyInvoices.toLowerCase()) ||
                    item.owner.toLowerCase().includes(this.billing.searchMyInvoices.toLowerCase()) ||
                    item.billto.toLowerCase().includes(this.billing.searchMyInvoices.toLowerCase()) ||
                    item.type.toLowerCase().includes(this.billing.searchMyInvoices.toLowerCase()) ||
                    item.referance.toLowerCase().includes(this.billing.searchMyInvoices.toLowerCase()) ||
                    item.description.toLowerCase().includes(this.billing.searchMyInvoices.toLowerCase()) ||
                    item.amount.toString().toLowerCase().includes(this.billing.searchMyInvoices.toLowerCase()) ||
                    item.date.toLowerCase().includes(this.billing.searchMyInvoices.toLowerCase());
            });
        },
        filteredReferance: function () {
            return this.billing.cityInvoices.filter(item => {
                if (this.billing.serachReferance == "") {
                    return;
                } else if (this.billing.serachReferance.toLowerCase() == item.referance.toLowerCase()) {
                    return item;
                }
            });
        },
        filteredAdmin: function () {
            return this.billing.cityInvoices.filter(item => {
                return item.title.toLowerCase().includes(this.billing.searchAdmin.toLowerCase()) ||
                    item.owner.toLowerCase().includes(this.billing.searchAdmin.toLowerCase()) ||
                    item.billto.toLowerCase().includes(this.billing.searchAdmin.toLowerCase()) ||
                    item.type.toLowerCase().includes(this.billing.searchAdmin.toLowerCase()) ||
                    item.referance.toLowerCase().includes(this.billing.searchAdmin.toLowerCase()) ||
                    item.description.toLowerCase().includes(this.billing.searchAdmin.toLowerCase()) ||
                    item.amount.toString().toLowerCase().includes(this.billing.searchAdmin.toLowerCase()) ||
                    item.date.toLowerCase().includes(this.billing.searchAdmin.toLowerCase());
            });
        },
        getDate: function () {
            let date = new Date();
            let day = date.getDate();
            let month = date.getMonth();
            let year = date.getFullYear();
            return `${year}-${month}-${day}`;
        },
        checkForm: function () {
            if (this.billing.newInvoiceForm.title == "" || this.billing.newInvoiceForm.amount == "" || this.billing.newInvoiceForm.description == "") {
                return false;
            } else {
                return true;
            }
        },
        checkUser: function () {
            let check = false;
            this.billing.userLists.forEach(item => {
                if (item.selected) {
                    check = true;
                }
            });
            return check;
        },
        formatUsd: function () {
            return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(this.posMachine.posInput);
        },
    },
    watch: {

    },
});

window.addEventListener("keydown", function (e) {
    if (e.key === "Escape") {
        app.post('closeNUI')
        app.close();
    }
  });