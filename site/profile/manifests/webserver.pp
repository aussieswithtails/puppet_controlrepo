class profile::webserver {

  include ::nginx
  include ::apache

  ::apache::listen {'127.0.0.1:8080':}

}
