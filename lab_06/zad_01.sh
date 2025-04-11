docker network create \
  --driver bridge \
  --subnet 192.168.1.0/24 \
  --gateway 192.168.1.1 \
  my_bridge

docker run -dit --name test_container --network my_bridge alpine sh

docker exec -it test_container sh
# wewnątrz kontenera
ip a
ping 192.168.1.1