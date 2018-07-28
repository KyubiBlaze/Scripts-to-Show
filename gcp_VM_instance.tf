// Configure the Google Cloud provider
	provider "google" {
  		credentials = "${file("file.json")}"  	//Service Account JSON key
  		project     = "project-id"  		//Project ID
  		region      = "us-central1"       	//Region
	}

// Create a new Compute instance
	resource "google_compute_instance" "default" {
  	name = "name"                             	//Name the Instance
  	zone         = "us-central1-a"            	//Specify Region
	machine_type = "custom-1-1024"            	/*MachineType eg n1-standard-1 or (For Custom:custom-<number of CPU>-<RAM in MiB>
							*/ 
							//1GiB=1024MiB
  	

  	//tags = ["foo", "bar"]                     	//Network Tags

  	boot_disk {				   	//Specify Boot Disk
     		//autodelete="false"			//Default: "true"
     		//device_name="Disk-name"
    		//disk_encryption_key_raw="Customer Supplied key in RFC 4648 base64"
		//source="The name or self_link of existing disk (such as those managed by google_compute_disk) to attach."
		initialize_params {
      			image = "ubuntu-os-cloud/ubuntu-1604-lts"	//https://cloud.google.com/compute/docs/images
			//size = "25"					//Disk size in GB :Default accourding to image
			//type = "pd-ssd"				//Default to pd-standard
  		}
  	}
	//can_ip_forward= "true"
	//description="Provide a description"
 	/*labels { 
		key="value"
	}
	*/	

// Local SSD disk
  	/* attached_disk {
      	//source="Name or Self_Link"
	//device_name="name to access it under /dev/disk/by-id/"
	//disk_encryption_key_raw="A 256-bit customer-supplied encryption key, encoded in RFC 4648 base64"
	}
	*/
	/*scratch_disk { 
		//interface="SCSI/NVME"      			//Defaults to SCSI                   	
  	}
	*/
	

  	network_interface {                      	//Network Configuration
    		network = "default" 			//Used only for default( Use either network or subnetwork , not both)
    		//subnetwork="subnet-name"		//Subnetwork name in same region provided(Not the VPC name)
		//subnetwork_project="Project self link"
		//address="Private custom IP"
		access_config{ 
			//Ephemeral IP auto given
			//nat_ip="*.*.*.*" 		//Must be in same region		
		}	
		/*alias_ip_range { 
		ip_cidr_range="10.128.5.0/29"  		//Available IP CIDR range in specified subnetwork for Alias
                //subnetwork_range_name="Secondary internal IP range to pick IP from"
		}
		*/
		
	}

  	/* metadata {					//Metadata Key-Value Pairs
    		foo = "bar"
  	}
	*/
	
  	/* scheduling {
		//preemptible="true"
		//on_host_maintenance="MIGRATE/TERMINATE"
		//automatic_restart="false"
 	}
	*/
	
	//min_cpu_platform="cpu architecture"  		//eg. "Intel Skylake"
	
	/* guest_accelerator{
		type="nvidia-tesla-k80"
		count="number within allowed range"
	*/
	
 	// metadata_startup_script = "script"   	//Startup Script

  	service_account {
		//email="service account email"
    		scopes = ["userinfo-email", "compute-ro", "storage-ro"]         //Service Account
  	}
}


