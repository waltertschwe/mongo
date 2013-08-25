## run processes for the cluster
## intial setup running on single dev machine

mkdir a0
mkdir a1
mkdir a2
mkdir b0
mkdir b1
mkdir b2
mkdir c0 
mkdir c1
mkdir c2
mkdir d0
mkdir d1
mkdir d2

mkdir cfg0
mkdir cfg1 
mkdir cfg2

## config serverA
mongod --configsvr --dbpath cfg0 --port 26050 --fork --logpath log.cfg0 --logappend
mongod --configsvr --dbpath cfg1 --port 26051 --fork --logpath log.cfg1 --logappend
mongod --configsvr --dbpath cfg2 --port 26052 --fork --logpath log.cfg2 --logappend

## shard servers (mongo data servers)
## don't use smallfiles in production and increase oplogSize
mongod --shardsvr --replSet a --dbpath a0 --logpath log.a0 --port 27000 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet a --dbpath a1 --logpath log.a1 --port 27001 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet a --dbpath a2 --logpath log.a2 --port 27002 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet b --dbpath b0 --logpath log.b0 --port 27100 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet b --dbpath b1 --logpath log.b1 --port 27101 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet b --dbpath b2 --logpath log.b2 --port 27102 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet c --dbpath c0 --logpath log.c0 --port 27200 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet c --dbpath c1 --logpath log.c1 --port 27201 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet c --dbpath c2 --logpath log.c2 --port 27202 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet d --dbpath d0 --logpath log.d0 --port 27300 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet d --dbpath d1 --logpath log.d1 --port 27301 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet d --dbpath d2 --logpath log.d2 --port 27302 --fork --logappend --smallfiles --oplogSize 50

## mongo processes
## first process runs on default port 27017
mongos --configdb domU-12-31-39-0E-31-D2:26050,domU-12-31-39-0E-31-D2:26051,domU-12-31-39-0E-31-D2:26052 --fork --logappend
mongos --configdb domU-12-31-39-0E-31-D2:26050,domU-12-31-39-0E-31-D2:26051,domU-12-31-39-0E-31-D2:26052 --fork --logappend --port 26061
mongos --configdb domU-12-31-39-0E-31-D2:26050,domU-12-31-39-0E-31-D2:26051,domU-12-31-39-0E-31-D2:26052 --fork --logappend --port 26062
mongos --configdb domU-12-31-39-0E-31-D2:26050,domU-12-31-39-0E-31-D2:26051,domU-12-31-39-0E-31-D2:26052 --fork --logappend --port 26063

echo 
ps -Aef | grep mongo

echo 
tail -n 1 log.cfg0
tail -n 1 log.cfg1
tail -n 1 log.cfg2 
