instance_groups = {"test-central-1" = "us-central1-a", "test-central-2" = "us-central1-b" }
apps = { app1 = { paths = ["/*"], port = 81}, app2 = { paths = ["/*"], port = 82}}
project = "example-project"
default_app = "app1"
lb_name = "central-lb"
ip_address_name = "public-central-ip"
url_maps = { central = { hosts = ["www.example.com"], default_app = "app1", apps = ["app1"]},
 	     tst = { hosts = ["app2.example.com"], default_app = "app2", apps = ["app2"]}
	   }
