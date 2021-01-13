# Assignment 3
Project นี้เป็นส่วนหนึ่งของวิชา Wireless Network
โดยใช้โครงสร้างของ Pet-Shop Web-Based DApp มาทำการพัฒนาให้เข้ากับการใช้งาน

## Reservation Web-Based DApp
เป็นการจำลอง Web-Based DApp สำหรับการจองรถสำหรับการเดินทางใน Route Line ต่างๆ

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

## Develope Web-Based DApp
### 1. Create Smart Contract
ใช้ Visual Studio Code เพื่อสร้างไฟล์ชื่อ Booking.sol ในไดเร็กทอรี contracts โดยมีโค้ดดังนี้
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

ใช้ Visual Studio Code ในการสร้างไฟล์ 2_deploy_contracts.js ในไดเร็กทอรี migrations ดังนี้
```
var Booking = artifacts.require("Booking");

module.exports = function(deployer) {
  deployer.deploy(Booking);
};
```
เปิดโปรแกรม Ganache โดยการใช้เมาส์ดับเบิลคลิกที่ชื่อไฟล์ จากนั้น Click ที่ New Workspace ในกรณีที่ใช้งานครั้งแรก หรือ Click ที่ Workspace ที่ต้องการใช้งาน
![Ganache](https://user-images.githubusercontent.com/74085959/104412400-c0a27c80-559e-11eb-9f71-76b59eb9e934.png)

จากนั้นทำการ Migrate โดยใช้คำสั่ง 
```
truffle migrate
```


### 3. Edit ฺBack-end 
ทำการแก้ไข Backend ใน Directory src 

#### 3.1 Replace image
ให้นำไฟล์ภาพที่ต้องการแสดงผลไปไว้ใน Directory image

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
ทำการแก้ไขตัวแปลต่างๆ  รวมถึง Template ให้เป็นดัง Code ด้านล่าง
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

### 3. Edit ฺFront-end 
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
        <!-- PETS LOAD HERE -->
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
ทำการ Run Backend  โดยใช้คำสั่ง
```
npm run dev
```
Firefox จะถูกเรียกใช้งานที่ URL http://localhost:3000 และแสดงผลลัพธ์
![Page 1](https://user-images.githubusercontent.com/74085959/104412760-87b6d780-559f-11eb-8676-a246fcb572ac.png)
![page 2](https://user-images.githubusercontent.com/74085959/104412795-97ceb700-559f-11eb-9534-4912792544a6.png)
