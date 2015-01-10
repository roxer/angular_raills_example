angular.module('ui.bootstrap.demo.services', ['rails']);
angular.module('ui.bootstrap.demo.services')
.factory('AreaService', ['railsResourceFactory', function (railsResourceFactory) {
    return railsResourceFactory({
        url: '/areas',
        name: 'area'
    });
}]);
