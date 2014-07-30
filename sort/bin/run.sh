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

echo "========== running sort bench =========="
# configure
DIR=`cd $bin/../; pwd`
. "${DIR}/../bin/bootstrap.sh"

check_compress

$HADOOP_EXECUTABLE $RMDIR_CMD $OUTPUT_HDFS

echo "== start MR job =="
# pre-running
START_TIME=`timestamp`

TMPLOGFILE=tmplog.log

# run bench
$HADOOP_EXECUTABLE jar $HADOOP_EXAMPLES_JAR sort $HADOOP_OPTIONS \
 -Dmapred.job.reuse.jvm.num.tasks=1000 \
 -Dio.sort.factor=32 \
 -Dio.sort.mb=1300 \
    $COMPRESS_OPT \
    -outKey org.apache.hadoop.io.Text \
    -outValue org.apache.hadoop.io.Text \
    -r ${NUM_REDS} \
    $INPUT_HDFS $OUTPUT_HDFS \
    2>&1 | tee $TMPLOGFILE

# post-running
END_TIME=`timestamp`

echo "== MR job done=="

if [ "x"$HADOOP_VERSION == "xhadoop2" ]; then
  SIZE=`grep "Bytes Read" $TMPLOGFILE | sed 's/Bytes Read=//'`
else
  SIZE=$($HADOOP_EXECUTABLE job -history $INPUT_HDFS | grep 'org.apache.hadoop.examples.RandomTextWriter$Counters.*|BYTES_WRITTEN')
  SIZE=${SIZE##*|}
  SIZE=${SIZE//,/}
fi

rm -rf $TMPLOGFILE
gen_report "SORT" ${START_TIME} ${END_TIME} ${SIZE}

