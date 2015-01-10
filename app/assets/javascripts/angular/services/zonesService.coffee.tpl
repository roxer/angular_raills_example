###
  RESTful service to handle data of employees
  using angularjs-rails-resource
  @see: http://ngmodules.org/modules/angularjs-rails-resource
###
angular.module('mfindAdmin.services').factory('ZonesService', [
  '$log'
  'railsResourceFactory'
  ($log, railsResourceFactory) ->
    resource = railsResourceFactory
      url: '/zones'
      name: 'zone'
])
