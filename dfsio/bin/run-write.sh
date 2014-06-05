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

bin=`dirname "$0"`
bin=`cd "$bin"; pwd`

echo "========== Running dfsioe write =========="
# configure
DIR=`cd $bin/../; pwd`
. "${DIR}/../bin/bootstrap.sh"

#path check
#$HADOOP_EXECUTABLE $RMDIR_CMD ${INPUT_HDFS}

# pre-running
OPTION="-write -nrFiles ${WT_NUM_OF_FILES} -fileSize ${WT_FILE_SIZE} -bufferSize 4096"
START_TIME=`timestamp`

#run benchmark
${HADOOP_EXECUTABLE} jar /usr/lib/hadoop-0.20-mapreduce/hadoop-test.jar TestDFSIO ${HADOOP_OPTIONS} \
 ${OPTION} -resFile ${DIR}/result_write.txt 

# post-running
END_TIME=`timestamp`
SIZE=`dir_size $INPUT_HDFS`
gen_report "DFSIO-WRITE" ${START_TIME} ${END_TIME} ${SIZE}

