#! /usr/bin/env bash

# ================================================================================
#  File Name    : extools/plugin-in-up/metals.sh
#  Author       : AlanDing
#  Created Time : Thu 25 Apr 2019 09:57:36 PM CST
# ================================================================================

# Make sure to use coursier v1.1.0-M9 or newer.
scalahome=/opt/lang-tools/scala

cd $scalahome || exit 1

if [ ! -x $scalahome/coursier ]; then
  sudo rm -f coursier && rm -f $scalahome/coc/metals-vim && rm -f $scalahome/languageclient/metals-vim

  sudo curl -L -o coursier https://git.io/coursier && chmod +x coursier
fi


$scalahome/coursier bootstrap \
  --java-opt -Xss4m \
  --java-opt -Xms100m \
  --java-opt -Dmetals.client=coc.nvim \
  --java-opt -Dmetals.java-home=/opt/lang-tools/java/jdk \
  --java-opt -Dmetals.sbt-script=/opt/lang-tools/scala/sbt/bin/sbt \
  --java-opt -Dmetals.extensions=true \
  --java-opt -Dmetals.status-bar=on \
  --java-opt -Dmetals.slow-task=on \
  --java-opt -Dmetals.input-box=on \
  --java-opt -Dmetals.icons=unicode \
  --java-opt -Dmetals.http=true \
  org.scalameta:metals_2.12:0.7.6 \
  -r bintray:scalacenter/releases \
  -r sonatype:snapshots \
  -o /opt/lang-tools/scala/coc/metals-vim -f

# $scalahome/coursier bootstrap \
  # --java-opt -Xss4m \
  # --java-opt -Xms100m \
  # --java-opt -Dmetals.client=LanguageClient-neovim \
  # --java-opt -Dmetals.java-home=/opt/lang-tools/java/jdk \
  # --java-opt -Dmetals.sbt-script=/opt/lang-tools/scala/sbt/bin/sbt \
  # --java-opt -Dmetals.extensions=true \
  # --java-opt -Dmetals.status-bar=on \
  # --java-opt -Dmetals.slow-task=on \
  # --java-opt -Dmetals.input-box=on \
  # --java-opt -Dmetals.icons=unicode \
  # --java-opt -Dmetals.http=true \
  # org.scalameta:metals_2.12:0.7.6 \
  # -r bintray:scalacenter/releases \
  # -r sonatype:snapshots \
  # -o /opt/lang-tools/scala/languageclient/metals-vim -f

