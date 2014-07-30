#!/bin/bash
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# paths
INPUT_HDFS=/benchmarks/TestDFSIO

REPLICATION_FACTOR=1
#64k  = 65536
#512k = 524288
BUFFER_SIZE=65536  

HADOOP_OPTIONS="-Ddfs.blocksize=128M"

# dfsioe-read
RD_NUM_OF_FILES=128
RD_FILE_SIZE=10000 #2000 in MB

# dfsioe-write
WT_NUM_OF_FILES=128
WT_FILE_SIZE=10000 #1000 in MB
