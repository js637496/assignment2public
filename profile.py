"""Assignment 2"""

# Import the Portal object.
import geni.portal as portal
# Import the ProtoGENI library.
import geni.rspec.pg as pg
# Import the Emulab specific extensions.
import geni.rspec.emulab as emulab

# Create a portal object,
pc = portal.Context()

# Create a Request object to start building the RSpec.
request = pc.makeRequestRSpec()

#set up lan
link = request.LAN("lan")

# Node webserver
node_webserver = request.XenVM('webserver')
node_webserver.routable_control_ip = True
iface = node_webserver.addInterface("if1")
iface.component_id = "eth1"
iface.addAddress(pg.IPv4Address("192.168.1.1", "255.255.255.0"))
link.addInterface(iface)
node_webserver.addService(pg.Execute(shell="sh", command="sudo apt update"))
node_webserver.addService(pg.Execute(shell="sh", command="sudo git clone https://github.com/js637496/assignment2public.git"))
node_webserver.addService(pg.Execute(shell="sh", command="sleep 10s"))
node_webserver.addService(pg.Execute(shell="sh", command="sudo mkdir -p /local/repository"))
node_webserver.addService(pg.Execute(shell="sh", command="sudo mv -v /assignment2public/* /local/repository/"))
node_webserver.addService(pg.Execute(shell="sh", command="sudo chmod 755 /local/repository/webserver_setup.sh"))
node_webserver.addService(pg.Execute(shell="sh", command="sudo /local/repository/webserver_setup.sh"))


# Node observer
node_observer = request.XenVM('observer')
node_observer.routable_control_ip = True
iface2 = node_observer.addInterface("if2")
iface2.component_id = "eth1"
iface2.addAddress(pg.IPv4Address("192.168.1.2", "255.255.255.0"))
link.addInterface(iface2)
node_observer.addService(pg.Execute(shell="sh", command="sudo apt update"))
node_observer.addService(pg.Execute(shell="sh", command="sudo git clone https://github.com/js637496/assignment2public.git"))
node_webserver.addService(pg.Execute(shell="sh", command="sleep 10s"))
node_observer.addService(pg.Execute(shell="sh", command="sudo mkdir -p /local/repository"))
node_observer.addService(pg.Execute(shell="sh", command="sudo mv -v /assignment2public/* /local/repository/"))
node_observer.addService(pg.Execute(shell="sh", command="sudo chmod 755 /local/repository/observer_setup.sh"))
node_observer.addService(pg.Execute(shell="sh", command="sudo /local/repository/observer_setup.sh"))

#Set mount the NFS director in the server, set up the cronjob
node_webserver.addService(pg.Execute(shell="sh", command="sudo chmod 755 /local/repository/webserver_setup_complete.sh"))


# Print the generated rspec
pc.printRequestRSpec(request)
