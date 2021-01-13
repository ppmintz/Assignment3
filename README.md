# Assignment 3
Project นี้เป็นส่วนหนึ่งของวิชา Wireless Network  
โดยใช้โครงสร้างของ Pet-Shop Web-Based DApp มาทำการพัฒนาให้เข้ากับการใช้งาน

## Reservation Web-Based DApp
เป็นการจำลอง Web-Based DApp สำหรับการจองรถสำหรับการเดินทางใน Route Line ต่างๆ โดยมีโครงสร้างพอสังเขปดังนี้

### Smart Contract
   สำหรับโปรเจคนี้ Smart Contract ถูกสร้างขึ้นภายใต้ชื่อ File Booking.sol (เขียนด้วย Solidity)     
   ภายใต้ Contract ชื่อ Booking  
   โดยมี Address = 8 Address สำหรับ CarID  
   Function Reserve สามารถ Reserve CarID โดย Bookers และเปลี่ยนสถานะกลับไปยัง CarID เมื่อถูก Reserve แล้ว  

### Deploy Contract
   ทำการ Migrate Smart Contract Booking สู่ Block-Chain

### Front-End
   index.html หรือ Front-End File สำหรับสร้าง User Interface ที่เชื่อมต่อกับผู้ใช้งาน  
   โดยเรียกใช้ Back-end หรือ src ต่างๆ อาทิ app.js , js/truffle-contract.js เป็นต้น  
   สามารถปรับแต่งรูปแบบการแสดงผลต่างๆ เช่น Background , Front , Name of Tab ได้ที่ File นี้  

### Back-End
   app.js หรือ Back-end File สำหรับ Coding program  
   โดยภายใต้ File นี้จะมีการเรียกใช้ File ต่างๆ และ คืนค่ากลับไปยังตัวแปรต่างๆ  
   อาทิ การเรียกใช้ไฟล์ด้วยคำสั่ง get.json เรียกใช้ Cars.json โดยมีคำสั่ง For Loop  
   เพื่อดึงข้อมูลสำหรับตั้งค่าตัวแปรต่างๆให้กับ CarsTemplate สำหรับแสดงผลใน Front-end  
   initWeb3 เป็นการระบุว่าจะใช้ Block-chain ใด (web3) ในการเชื่อมต่อกับ Smart Contract  (Metamask ,Legacy browser และ Ganache)
   markAdopted เป็น Function เชื่อมต่อไปยัง Wallet address และเมื่อมี Transaction เกิดขึ้นการแสดงผลของปุ่น Reserve จะเปลี่ยนเป็น Reserved เป็นต้น

## กำหนดค่าสิ่งแวดล้อม
สร้าง Directory สำหรับบันทึก Projectนี้ และ ใช้คำสั่งต่อไปนี้เพื่อสร้างและย้ายเข้าไปยัง Directory ชื่อ Ass3
```
mkdir Ass3
cd Ass3
```

ดาวน์โหลดโครงสร้างของโปรเจ็ค pet-shop ซึ่งมีอยู่ใน Truffle Framework โดยใช้คำสั่งต่อไปนี้
```
truffle unbox pet-shop
```
โดยจะได้ Directory ต่างๆ  
contracts >> Directory สำหรับเก็บ Smart Contracts ที่เขียนด้วยภาษา Solidity  
migrations >> Directory สำหรับเก็บ File JavaScript ซึ่งเป็น Code ที่ใช้ในการจัดการ Smart Contracts ให้ลงไปยัง Block Chain  
src >> Directory สำหรับเก็บ File ที่เกี่ยวข้องกับ Web Application เช่น JavaScript, CSS, HTML, images เป็นต้น  
truffle-config.js >> File ที่ใช้ในการกำหนดค่าของโปรเจ็ค  

## Develop Web-Based DApp
### 1. Create Smart Contract
ใช้ Visual Studio Code เพื่อสร้างไฟล์ชื่อ Booking.sol ใน contracts Directory โดยมีโค้ดดังนี้
```
pragma solidity ^0.5.0;

contract Booking {
    address[8] public Bookers;

    function Reserve(uint CarID) public returns (uint) {
        require(CarID >= 0 && CarID <=7);
        Bookers[CarID] = msg.sender;
        return CarID;
    }

    function getBookers() public view returns (address[8] memory) {
        return Bookers;
    }
}
```

### 2. Compile และ Migrate
ทำการ Compile Smart Contracts โดยใช้คำสั่ง
```
truffle compile
```
โปรดตรวจสอบว่า Compile Smart Contracts ได้สำเร็จก่อนทำในขั้นตอนต่อไป

เปิดโปรแกรม Ganache โดยการใช้เมาส์ดับเบิลคลิกที่ชื่อไฟล์ จากนั้น Click ที่ New Workspace  
ในกรณีที่ใช้งานครั้งแรก หรือ Click ที่ Workspace ที่ต้องการใช้งาน

![Ganache](https://user-images.githubusercontent.com/74085959/104412400-c0a27c80-559e-11eb-9f71-76b59eb9e934.png)

![Ganache2](https://user-images.githubusercontent.com/74085959/104414342-ae2a4200-55a2-11eb-89a9-7c6a497a02d4.png)

ใช้ Visual Studio Code ในการสร้างไฟล์ 2_deploy_contracts.js ใน migrations Directory ดังนี้
```
var Booking = artifacts.require("Booking");

module.exports = function(deployer) {
  deployer.deploy(Booking);
};
```

จากนั้นทำการ Migrate โดยใช้คำสั่ง 
```
truffle migrate
```
### >> Connect Ganache to MetaMask
![Metamask](https://user-images.githubusercontent.com/74085959/104418187-1b40d600-55a9-11eb-8872-a04ef6cb97cd.png)

  1 Install MetaMask to Firefox  
  2 Click Get Started  
  3 Import Wallet  
    - Copy Seed จาก Ganache ทำการ Paste ที่ MetaMask Wallet Seed    
    - Set password และ เลือก I have read and agree to the Terms of Use จากนั้น Click Import     
    -  Click ที่แถบ Ethereum Mainnet แล้วเลือก Custom RPC       
    -  ตั้งค่าต่างๆ     
>>> Network Name >> Ganache (เป็นค่าใดๆ ก็ได้)  
>>> New RPC URL >> http://127.0.0.1:7545 (URL ของ Ganache)             
>>> Chain id >> 5777 (Ganache Network id)


### 3. Edit Back-end 
ทำการแก้ไข Back-end ใน src Directory 

#### 3.1 Replace image
ให้นำไฟล์ภาพที่ต้องการแสดงผลไปไว้ใน image  Directory

#### 3.2 Edit File.json
ทำการ Rename จาก pets.json ให้เป็น cars.json และ Edit Code ให้เป็นดังต่อไปนี้
```
[
  {
    "id": 0,
    "name": "Altis",
    "picture": "images/Altis.jpeg",
    "Seats": 2,
    "Model": "Toyota - Altis",
    "Route": "BKK - PKT"
  },
  {
    "id": 1,
    "name": "Camry",
    "picture": "images/Camry.jpeg",
    "Seats": 3,
    "Model": "Toyota - Camry",
    "Route": "BKK - LPG"
  },
  {
    "id": 2,
    "name": "CHR",
    "picture": "images/CHR.jpeg",
    "Seats": 3,
    "Model": "Toyota - CHR",
    "Route": "BKK - MSN"
  },
  {
    "id": 3,
    "name": "City",
    "picture": "images/City.jpeg",
    "Seats": 2,
    "Model": "Honda - City",
    "Route": "BKK - PLK"
  },
  {
    "id": 4,
    "name": "Civic",
    "picture": "images/Civic.jpeg",
    "Seats": 3,
    "Model": "Honda - Civic",
    "Route": "BKK - CMI"
  },
  {
    "id": 5,
    "name": "CRV",
    "picture": "images/CRV.jpeg",
    "Seats": 3,
    "Model": "Honda - CRV",
    "Route": "BKK - ACR"
  },
  {
    "id": 6,
    "name": "Fortuner",
    "picture": "images/Fortuner.jpeg",
    "Seats": 5,
    "Model": "Toyota - Fortuner",
    "Route": "BKK - CRI"
  },
  {
    "id": 7,
    "name": "Pajero",
    "picture": "images/Pajero.jpeg",
    "Seats": 5,
    "Model": "Mitsubishi - Pajero",
    "Route": "BKK - KBI"
  }
  
]
```
#### 3.3 Edit app.js
ทำการแก้ไขตัวแปรต่างๆ  รวมถึง Template ให้เป็นดัง Code ด้านล่าง
จะเห็นได้ว่ามีการเรียกใช้ข้อมูล cars.json
```
App = {
  web3Provider: null,
  contracts: {},

  init: async function() {
    // Load cars.
    $.getJSON('../cars.json', function(data) {
      var carsRow = $('#carsRow');
      var CarsTemplate = $('#CarsTemplate');

      for (i = 0; i < data.length; i ++) {
        CarsTemplate.find('.panel-title').text(data[i].name);
        CarsTemplate.find('img').attr('src', data[i].picture);
        CarsTemplate.find('.car-Seats').text(data[i].Seats);
        CarsTemplate.find('.car-Model').text(data[i].Model);
        CarsTemplate.find('.car-Route').text(data[i].Route);
        CarsTemplate.find('.btn-Reserve').attr('data-id', data[i].id);

        carsRow.append(CarsTemplate.html());
      }
    });

    return await App.initWeb3();
  },

  initWeb3: async function() {
    // Modern dapp browsers...
    if (window.ethereum) {
      App.web3Provider = window.ethereum;
      try {
        // Request account access
        await window.ethereum.enable();
      } catch (error) {
        // User denied account access...
        console.error("User denied account access")
      }
    }
    // Legacy dapp browsers...
    else if (window.web3) {
      App.web3Provider = window.web3.currentProvider;
    }
    // If no injected web3 instance is detected, fall back to Ganache
    else {
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
    }
    web3 = new Web3(App.web3Provider);

    return App.initContract();
  },

  initContract: function() {
    $.getJSON('Booking.json', function (data) {
      // Get the necessary contract artifact file and instantiate it with @truffle/contract
      var BookingArtifact = data;
      App.contracts.Booking = TruffleContract(BookingArtifact);

      // Set the provider for our contract
      App.contracts.Booking.setProvider(App.web3Provider);

      // Use our contract to retrieve and mark the Reserved pets
      return App.markAdopted();
    });
    return App.bindEvents();
  },

  bindEvents: function() {
    $(document).on('click', '.btn-Reserve', App.handleReserve);
  },

  markAdopted: function() {
    var BookingInstance;

    App.contracts.Booking.deployed().then(function (instance) {
      BookingInstance = instance;

      return BookingInstance.getBookers.call();
    }).then(function (Bookers) {
      for (i = 0; i < Bookers.length; i++) {
        if (Bookers[i] !== '0x0000000000000000000000000000000000000000') {
          $('.panel-car').eq(i).find('button').text('Reserved').attr('disabled', true);
        }
      }
    }).catch(function (err) {
      console.log(err.message);
    });
  },

  handleReserve: function(event) {
    event.preventDefault();

    var CarID = parseInt($(event.target).data('id'));

    var BookingInstance;

    web3.eth.getAccounts(function (error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      App.contracts.Booking.deployed().then(function (instance) {
        BookingInstance = instance;

        // Execute Reserve as a transaction by sending account
        return BookingInstance.Reserve(CarID, { from: account });
      }).then(function (result) {
        return App.markAdopted();
      }).catch(function (err) {
        console.log(err.message);
      });
    });
  }

};

$(function() {
  $(window).load(function() {
    App.init();
  });
})
```

### 3. Edit Front-end 
ทำการแก้ไขในส่วนของ User Interface ให้มี Code ต่างๆดังรูป
จะเห็นได้ว่ามีการเรียกใช้ Template การแสดงผลจาก Back-end
```
<!DOCTYPE html>
<html lang="en">
     <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
     <!-- Include all compiled plugins (below), or include individual files as needed -->
     <script src="js/bootstrap.min.js"></script>
     <script src="js/web3.min.js"></script>
     <script src="js/truffle-contract.js"></script>
     <script src="js/app.js"></script>

  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Are you ready?</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
    <div class="container">
      <div class="row">
        <div class="col-xs-12 col-sm-8 col-sm-push-2">
          <h1 class="text-center">They're available for you</h1>
            <center><img src="https://paapaii.com/wp-content/uploads/2019/09/130919-%E0%B8%9E%E0%B8%B2%E0%B9%84%E0%B8%9B-%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B9%80%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B8%A2%E0%B8%A7%E0%B8%AA%E0%B8%A7%E0%B8%A2%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%84%E0%B8%97%E0%B8%A2-cover-1024x683.jpg" alt="Unseen" width="960" height="480"></center>
            <style>
              body {
                background-image: url('https://motionarray.imgix.net/preview-291523-KDuFUjnVQC-high_0000.jpg');
                background-repeat: no-repeat;
                background-attachment: fixed; 
                background-size: 100% 100%;
              }
              </style>
            <hr/>
          <br/>
        </div>
      </div>

      <div id="carsRow" class="row">
        <!-- CARS LOAD HERE -->
      </div>
    </div>
  
    
    
   <center> <div id="CarsTemplate" style="display:none;">
      <div class="col-sm-4 col-md-4 col-lg-3">
        <div class="panel panel-default panel-car">
          <div class="panel-heading">
      
              </script>
            <h3 class="panel-title"><center>Brand</center></h3>
          </div>
          <div class="panel-body">
            <img alt="140x140" data-src="holder.js/140x140" class="img-rounded img-center" style="width: 100%;" src="http://localhost:3000/images/Altis.jpeg" data-holder-rendered="true">
            <br/><br/>
            <strong>Model</strong>: <span class="car-Model">X</span><br/>
            <strong>Seats</strong>: <span class="car-Seats">1</span><br/>
            <strong>Route</strong>: <span class="car-Route">D - D</span><br/><br/>
            <center><button class="btn btn-default btn-Reserve" type="button" data-id="0">Reserve</button></center>
          </div>
        </div>
      </div>
    </div></center>

 
  </body>
</html>
```

### 4. Run
ทำการ Run Back-end  โดยใช้คำสั่ง
```
npm run dev
```
Firefox จะถูกเรียกใช้งานที่ URL http://localhost:3000 และแสดงผลลัพธ์
![Page 1](https://user-images.githubusercontent.com/74085959/104412760-87b6d780-559f-11eb-8676-a246fcb572ac.png)

![page 2](https://user-images.githubusercontent.com/74085959/104412795-97ceb700-559f-11eb-9534-4912792544a6.png)

เมื่อมีการกด Reserve MetaMask จะถูกเรียกขึ้นมา 
![Res1](https://user-images.githubusercontent.com/74085959/104424108-8393b580-55b1-11eb-90ea-b6c1c2317fde.png)

และเมื่อการจ่าย Gas เสร็จสมบูรณ์ Reserve จะถูกเปลี่ยนเป็น Reserved 
![Res2](https://user-images.githubusercontent.com/74085959/104424117-85f60f80-55b1-11eb-9150-39074cda7c9b.png)

Transaction แสดงรายละเอียดดังรูป
![Transaction](https://user-images.githubusercontent.com/74085959/104425106-d621a180-55b2-11eb-89ab-2be86eacb2d8.png)



