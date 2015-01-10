angular.module('ui.bootstrap.demo',
        ['ngRoute', 'ngResource', 'ui.bootstrap',
         'ui.grid', 'ui.bootstrap.demo.services', 'angular-underscore',
         'restangular'])
.config(//{{{
  //'$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  function($routeProvider, $locationProvider, RestangularProvider) {
    $routeProvider.when('/static_pages/index',{
      templateUrl: '/templates/index.html',
      controller: 'CarsCtrl'
    })
    .when('/static_pages/index2',{
      templateUrl: '/templates/index2.html',
      controller: 'CarsCtrl'
    })
    .when('/static_pages/index3',{
      templateUrl: '/templates/index3.html',
      controller: 'CarsCtrl'
    });

    $routeProvider.otherwise({
      redirectTo: '/static_pages/index'
    });
    RestangularProvider.setBaseUrl('http://localhost:3000/');
    //RestangularProvider.setBaseUrl('http://pkbadmin-dev.mfind.pl/');
    RestangularProvider.setDefaultRequestParams('jsonp', {callback: 'JSON_CALLBACK'});
    //RestangularProvider.addElementTransformer('eurotax', true, function(eurotax) {
        // This will add a method called login that will do a POST to the path login
        // signature is (name, operation, path, params, headers, elementToPost)

        //eurotax.addRestangularMethod('cars', 'post', 'eurotax');

        //return eurotax;
    //});
  }
) //.config(function(RestangularProvider) { // RestangularProvider.setRequestSuffix('.json'); //})//}}}
.controller('CarsCtrl', function($scope, Restangular) {//{{{

  Restangular.all('eurotax/brands').getList({id: 'pkw'})//{{{
  .then(function(value) {
    $scope.brands = value;
  }, function() {
    console.log("There was an error getting brands");
  })//}}}

  $scope.models = [];//{{{
  $scope.fuels = [];
  $scope.gears = [];
  $scope.cars = [];

  $scope.brand = null;
  $scope.model = null;
  $scope.fuel  = null;
  $scope.gear  = null;
  $scope.year  = "--";
  $scope.door  = "--"
  $scope.body  = "--";
  $scope.capacity = "--";
  $scope.power = "--";
  $scope.doors = ["--"];
  $scope.capacities = ["--"];
  $scope.powers = ["--"];
  $scope.bodies = ["--"];
  $scope.years = ["--"];
  $scope.ajaxLoader = false;//}}}

  resetFilters = function () {//{{{
    $scope.doors = ["--"];
    $scope.capacities = ["--"];
    $scope.powers = ["--"];
    $scope.bodies = ["--"];
    $scope.years = ["--"];
  }//}}}

  $scope.changeBrand = function () {//{{{
    Restangular.all('eurotax/models').getList({id: $scope.brand.make_name})
    .then(function(cars) {
      $scope.models = cars;
    }, function() {
      console.log("There was an error getting brands");
    })

    $scope.fuels = [];
    $scope.gears = [];
    $scope.gear = null;
    resetFilters();
  }//}}}

  $scope.changeModel = function () {//{{{
    Restangular.all('eurotax/fuels')
    .getList({brand: $scope.brand.make_name, model: $scope.model.model_name})
    .then(function(cars) {
      $scope.fuels = cars;
      if ($scope.fuels.length == 1) {
        $scope.fuel = $scope.fuels[0];
        $scope.changeFuel();
      }
    }, function() {
      console.log("There was an error getting fuels");
    })
    $scope.gears = [];
    $scope.gear = null;
    resetFilters();
  }//}}}

  $scope.changeFuel = function () {//{{{
    Restangular.all('eurotax/gears')
    .getList({brand: $scope.brand.make_name,
              fuel: $scope.fuel.fuel_code,
              model: $scope.model.model_name})
    .then(function(cars) {
      $scope.gears = cars;
      if ($scope.gears.length == 1) {
        $scope.gear = $scope.gears[0];
        $scope.changeGear();
      }
    }, function() {
      console.log("There was an error getting gears");
    })
    $scope.gear = null;
  }//}}}

  $scope.changeGear = function () {//{{{
    $scope.ajaxLoader = true;
    Restangular.all('eurotax/cars')
    .getList({brand: $scope.brand.make_name,
              gear: $scope.gear.trans_code,
              fuel: $scope.fuel.fuel_code,
              model: $scope.model.model_name})
    .then(function(value) {

      cars = value;
      $scope.cars = cars;
      resetFilters();
      $scope.setFilters(true);
    }, function() {
      console.log("There was an error getting cars");
    })
    .finally(function(value) {
      $scope.ajaxLoader = false;
    })
    //console.log("mod"+$scope.powers);
  }//}}}

  $scope.setFilters = function (reset) {//{{{
    // console.log("There was cars to filter: "+$scope.cars.length);
    if (reset) {
      $scope.cars = cars;
      $scope.year  = "--";
      $scope.door  = "--"
      $scope.body  = "--";
      $scope.capacity = "--";
      $scope.power = "--";
    }
    var y = [];
    var ranges = [];
    $scope.doors = ["--"];
    $scope.capacities = ["--"];
    $scope.powers = ["--"];
    $scope.bodies = ["--"];
    $scope.years = ["--"];
    console.log("There was bodies to filter: "+$scope.bodies.length);

    _.filter($scope.cars, function (el) {
      $scope.doors.push(el["doors"]);
      $scope.capacities.push(el["engine_capacity"]);
      $scope.powers.push(el["power_hp"]);
      $scope.bodies.push(el["body_name"]);
      y.push(parseInt(el["begin_year"]));
      if (el["end_year"] != null) {
        y.push(parseInt(el["end_year"]));
        ranges.push( _.range(parseInt(el["begin_year"]), parseInt(el["end_year"])+1));
      } else {
        ranges.push( _.range(parseInt(el["begin_year"]), 2016));
      }
    });

    $scope.doors  = _.uniq($scope.doors).sort();
    $scope.capacities = _.uniq($scope.capacities).sort();
    $scope.powers = _.uniq($scope.powers).sort();
    $scope.bodies = _.uniq($scope.bodies).sort();
    $scope.years = _.union($scope.years,
                            _.uniq(_.flatten(ranges)).sort());
                           //_.range(_.min(y), _.max(y)+1));

  }//}}}

  $scope.filterCars = function () {//{{{
    $scope.cars = cars.filter(function (el) {
      var p, y, d, c, b;
      if ($scope.capacity == el.engine_capacity) c = true;
      if ($scope.power == el.power_hp) p = true;
      if ($scope.door == el.doors) d = true;
      if ($scope.body == el.body_name) b = true;

      if ($scope.year >= parseInt(el.begin_year) &&
           (el.end_year == null ||
             $scope.year <= parseInt(el.end_year))) y = true;


      if (($scope.capacity == "--" || c) &&
          ($scope.power == "--" || p)    &&
          ($scope.year == "--" || y)     &&
          ($scope.door == "--" || d)     &&
          ($scope.body == "--" || b) ) return true;
    });

    $scope.setFilters(false);
  }//}}}

})//}}}
.controller('TabsDemoCtrl', function ($scope, $window, $location) {//{{{
      $scope.tabs = [
    { title:'Dynamic Title 1', content:'Dynamic content 1' },
    { title:'Dynamic Title 2', content:'Dynamic content 2', disabled: true }
  ];

  $scope.alertMe = function() {
    setTimeout(function() {
      $window.alert('You\'ve selected the alert tab!');
    });
  };

})//}}}
.controller('RatingDemoCtrl', function ($scope) {//{{{
  $scope.rate = 7;
  $scope.max = 10;
  $scope.isReadonly = false;

  $scope.hoveringOver = function(value) {
    $scope.overStar = value;
    $scope.percent = 100 * (value / $scope.max);
  };

  $scope.ratingStates = [
    {stateOn: 'glyphicon-ok-sign', stateOff: 'glyphicon-ok-circle'},
    {stateOn: 'glyphicon-star', stateOff: 'glyphicon-star-empty'},
    {stateOn: 'glyphicon-heart', stateOff: 'glyphicon-ban-circle'},
    {stateOn: 'glyphicon-heart'},
    {stateOff: 'glyphicon-off'}
  ];
})//}}}
.controller('TimepickerDemoCtrl', function ($scope, $log) {//{{{
  $scope.mytime = new Date();

  $scope.hstep = 1;
  $scope.mstep = 15;

  $scope.options = {
    hstep: [1, 2, 3],
    mstep: [1, 5, 10, 15, 25, 30]
  };

  $scope.ismeridian = true;
  $scope.toggleMode = function() {
    $scope.ismeridian = ! $scope.ismeridian;
  };

  $scope.update = function() {
    var d = new Date();
    d.setHours( 14 );
    d.setMinutes( 0 );
    $scope.mytime = d;
  };

  $scope.changed = function () {
    $log.log('Time changed to: ' + $scope.mytime);
  };

  $scope.clear = function() {
    $scope.mytime = null;
  };

})//}}}
.controller('TypeaheadCtrl', function($scope, $http) {//{{{

  $scope.selected = undefined;
  $scope.states = ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York', 'North Dakota', 'North Carolina', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming'];
  // Any function returning a promise object can be used to load values asynchronously
  $scope.getLocation = function(val) {
    return $http.get('http://maps.googleapis.com/maps/api/geocode/json', {
      params: {
        address: val,
        sensor: false
      }
    }).then(function(response){
      return response.data.results.map(function(item){
        return item.formatted_address;
      });
    });
  };

  $scope.statesWithFlags = [{'name':'Alabama','flag':'5/5c/Flag_of_Alabama.svg/45px-Flag_of_Alabama.svg.png'},{'name':'Alaska','flag':'e/e6/Flag_of_Alaska.svg/43px-Flag_of_Alaska.svg.png'},{'name':'Arizona','flag':'9/9d/Flag_of_Arizona.svg/45px-Flag_of_Arizona.svg.png'},{'name':'Arkansas','flag':'9/9d/Flag_of_Arkansas.svg/45px-Flag_of_Arkansas.svg.png'},{'name':'California','flag':'0/01/Flag_of_California.svg/45px-Flag_of_California.svg.png'},{'name':'Colorado','flag':'4/46/Flag_of_Colorado.svg/45px-Flag_of_Colorado.svg.png'},{'name':'Connecticut','flag':'9/96/Flag_of_Connecticut.svg/39px-Flag_of_Connecticut.svg.png'},{'name':'Delaware','flag':'c/c6/Flag_of_Delaware.svg/45px-Flag_of_Delaware.svg.png'},{'name':'Florida','flag':'f/f7/Flag_of_Florida.svg/45px-Flag_of_Florida.svg.png'},{'name':'Georgia','flag':'5/54/Flag_of_Georgia_%28U.S._state%29.svg/46px-Flag_of_Georgia_%28U.S._state%29.svg.png'},{'name':'Hawaii','flag':'e/ef/Flag_of_Hawaii.svg/46px-Flag_of_Hawaii.svg.png'},{'name':'Idaho','flag':'a/a4/Flag_of_Idaho.svg/38px-Flag_of_Idaho.svg.png'},{'name':'Illinois','flag':'0/01/Flag_of_Illinois.svg/46px-Flag_of_Illinois.svg.png'},{'name':'Indiana','flag':'a/ac/Flag_of_Indiana.svg/45px-Flag_of_Indiana.svg.png'},{'name':'Iowa','flag':'a/aa/Flag_of_Iowa.svg/44px-Flag_of_Iowa.svg.png'},{'name':'Kansas','flag':'d/da/Flag_of_Kansas.svg/46px-Flag_of_Kansas.svg.png'},{'name':'Kentucky','flag':'8/8d/Flag_of_Kentucky.svg/46px-Flag_of_Kentucky.svg.png'},{'name':'Louisiana','flag':'e/e0/Flag_of_Louisiana.svg/46px-Flag_of_Louisiana.svg.png'},{'name':'Maine','flag':'3/35/Flag_of_Maine.svg/45px-Flag_of_Maine.svg.png'},{'name':'Maryland','flag':'a/a0/Flag_of_Maryland.svg/45px-Flag_of_Maryland.svg.png'},{'name':'Massachusetts','flag':'f/f2/Flag_of_Massachusetts.svg/46px-Flag_of_Massachusetts.svg.png'},{'name':'Michigan','flag':'b/b5/Flag_of_Michigan.svg/45px-Flag_of_Michigan.svg.png'},{'name':'Minnesota','flag':'b/b9/Flag_of_Minnesota.svg/46px-Flag_of_Minnesota.svg.png'},{'name':'Mississippi','flag':'4/42/Flag_of_Mississippi.svg/45px-Flag_of_Mississippi.svg.png'},{'name':'Missouri','flag':'5/5a/Flag_of_Missouri.svg/46px-Flag_of_Missouri.svg.png'},{'name':'Montana','flag':'c/cb/Flag_of_Montana.svg/45px-Flag_of_Montana.svg.png'},{'name':'Nebraska','flag':'4/4d/Flag_of_Nebraska.svg/46px-Flag_of_Nebraska.svg.png'},{'name':'Nevada','flag':'f/f1/Flag_of_Nevada.svg/45px-Flag_of_Nevada.svg.png'},{'name':'New Hampshire','flag':'2/28/Flag_of_New_Hampshire.svg/45px-Flag_of_New_Hampshire.svg.png'},{'name':'New Jersey','flag':'9/92/Flag_of_New_Jersey.svg/45px-Flag_of_New_Jersey.svg.png'},{'name':'New Mexico','flag':'c/c3/Flag_of_New_Mexico.svg/45px-Flag_of_New_Mexico.svg.png'},{'name':'New York','flag':'1/1a/Flag_of_New_York.svg/46px-Flag_of_New_York.svg.png'},{'name':'North Carolina','flag':'b/bb/Flag_of_North_Carolina.svg/45px-Flag_of_North_Carolina.svg.png'},{'name':'North Dakota','flag':'e/ee/Flag_of_North_Dakota.svg/38px-Flag_of_North_Dakota.svg.png'},{'name':'Ohio','flag':'4/4c/Flag_of_Ohio.svg/46px-Flag_of_Ohio.svg.png'},{'name':'Oklahoma','flag':'6/6e/Flag_of_Oklahoma.svg/45px-Flag_of_Oklahoma.svg.png'},{'name':'Oregon','flag':'b/b9/Flag_of_Oregon.svg/46px-Flag_of_Oregon.svg.png'},{'name':'Pennsylvania','flag':'f/f7/Flag_of_Pennsylvania.svg/45px-Flag_of_Pennsylvania.svg.png'},{'name':'Rhode Island','flag':'f/f3/Flag_of_Rhode_Island.svg/32px-Flag_of_Rhode_Island.svg.png'},{'name':'South Carolina','flag':'6/69/Flag_of_South_Carolina.svg/45px-Flag_of_South_Carolina.svg.png'},{'name':'South Dakota','flag':'1/1a/Flag_of_South_Dakota.svg/46px-Flag_of_South_Dakota.svg.png'},{'name':'Tennessee','flag':'9/9e/Flag_of_Tennessee.svg/46px-Flag_of_Tennessee.svg.png'},{'name':'Texas','flag':'f/f7/Flag_of_Texas.svg/45px-Flag_of_Texas.svg.png'},{'name':'Utah','flag':'f/f6/Flag_of_Utah.svg/45px-Flag_of_Utah.svg.png'},{'name':'Vermont','flag':'4/49/Flag_of_Vermont.svg/46px-Flag_of_Vermont.svg.png'},{'name':'Virginia','flag':'4/47/Flag_of_Virginia.svg/44px-Flag_of_Virginia.svg.png'},{'name':'Washington','flag':'5/54/Flag_of_Washington.svg/46px-Flag_of_Washington.svg.png'},{'name':'West Virginia','flag':'2/22/Flag_of_West_Virginia.svg/46px-Flag_of_West_Virginia.svg.png'},{'name':'Wisconsin','flag':'2/22/Flag_of_Wisconsin.svg/45px-Flag_of_Wisconsin.svg.png'},{'name':'Wyoming','flag':'b/bc/Flag_of_Wyoming.svg/43px-Flag_of_Wyoming.svg.png'}];//{{{//}}}
})//}}}
.controller('ModalDemoCtrl', function ($scope, $modal, $log) {//{{{

  $scope.items = ['item1', 'item2', 'item3'];

  $scope.open = function (size) {

    var modalInstance = $modal.open({
      templateUrl: 'myModalContent.html',
      controller: 'ModalInstanceCtrl',
      size: size,
      resolve: {
        items: function () {
          return $scope.items;
        }
      }
    });

    modalInstance.result.then(function (selectedItem) {
      $scope.selected = selectedItem;
    }, function () {
      $log.info('Modal dismissed at: ' + new Date());
    });
  };
})//}}}
.controller('ModalInstanceCtrl', function ($scope, $modalInstance, items) {//{{{

  // $scope.items = items;
  $scope.items = [
    'The first choice!',
    'And another choice for you.',
    'but wait! A third!'
  ];
  $scope.selected = {
    item: $scope.items[0]
  };

  $scope.ok = function () {
    $modalInstance.close($scope.selected.item);
  };

  $scope.cancel = function () {
    $modalInstance.dismiss('cancel');
  };
})//}}}
.controller('AreaCtrl', function ($scope, AreaService) {//{{{
  $scope.searching = true;
  $scope.wynik = [];

  AreaService.query({code: 'PL'}).then(function(results) {
    $scope.wynik = results;

  }, function (error) {
    // cos innego
  });
})//}}}
.controller('AccordionDemoCtrl', function ($scope) {//{{{
  $scope.oneAtATime = true;

  $scope.groups = [
    {
      title: 'Dynamic Group Header - 1',
      content: 'Dynamic Group Body - 1'
    },
    {
      title: 'Dynamic Group Header - 2',
      content: 'Dynamic Group Body - 2'
    }
  ];

  $scope.items = ['Item 1', 'Item 2', 'Item 3'];

  $scope.addItem = function() {
    var newItemNo = $scope.items.length + 1;
    $scope.items.push('Item ' + newItemNo);
  };

  $scope.status = {
    isFirstOpen: true,
    isFirstDisabled: false
  };
})//}}}
.controller('DropdownCtrl', function ($scope, $log) {//{{{
  $scope.items = [
    'The first choice!',
    'And another choice for you.',
    'but wait! A third!'
  ];

  $scope.status = {
    isopen: false
  };

  $scope.toggled = function(open) {
    $log.log('Dropdown is now: ', open);
  };

  $scope.toggleDropdown = function($event) {
    $event.preventDefault();
    $event.stopPropagation();
    $scope.status.isopen = !$scope.status.isopen;
  };
})//}}}
.controller('UiGridCtrl', function ($scope, $log) {//{{{

  $scope.myData = [
    {
        "firstName": "Cox",
        "lastName": "Carney",
        "company": "Enormo",
        "employed": true
    },
    {
        "firstName": "Lorraine",
        "lastName": "Wise",
        "company": "Comveyer",
        "employed": false
    },
    {
        "firstName": "Nancy",
        "lastName": "Waters",
        "company": "Fuelton",
        "employed": false
    }
  ];

});//}}}
;
