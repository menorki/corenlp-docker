FROM java:8

ENV CORENLP_VERSION=3.9.1
ENV CORENLP_ARCHIVE_VERSION=2018-02-27
ENV CORENLP_ARCHIVE=stanford-corenlp-full-${CORENLP_ARCHIVE_VERSION}.zip \
  CORENLP_ARCHIVE_EN=stanford-english-corenlp-${CORENLP_ARCHIVE_VERSION}-models.jar \
  CORENLP_ARCHIVE_EN_KBP=stanford-english-kbp-corenlp-${CORENLP_ARCHIVE_VERSION}-models.jar \
  CORENLP_SHA1SUM=c4fd33b6085d8ac4e8c6746b2c73d95da42d8da4 \
  CORENLP_PATH=/corenlp \
  CORENLP_SHA1_PATH=corenlp.sha1

RUN wget http://nlp.stanford.edu/software/$CORENLP_ARCHIVE \
  && echo "$CORENLP_SHA1SUM $CORENLP_ARCHIVE" > corenlp.sha1 \
  && sha1sum -c corenlp.sha1 \
  && unzip $CORENLP_ARCHIVE \
  && mv $(basename ../$CORENLP_ARCHIVE .zip) $CORENLP_PATH \
  && rm $CORENLP_ARCHIVE \
  && unzip $CORENLP_ARCHIVE_EN \
  && mv $(basename ../$CORENLP_ARCHIVE_EN .zip) $CORENLP_PATH \
  && rm $CORENLP_ARCHIVE_EN \
  && unzip $CORENLP_ARCHIVE_EN_KBP \
  && mv $(basename ../$CORENLP_ARCHIVE_EN_KBP .zip) $CORENLP_PATH \
  && rm $CORENLP_ARCHIVE_EN_KBP \
  && rm corenlp.sha1

WORKDIR $CORENLP_PATH

EXPOSE 9000
CMD ["java", "-mx4g", "-cp", "*", "edu.stanford.nlp.pipeline.StanfordCoreNLPServer", "9000"]
