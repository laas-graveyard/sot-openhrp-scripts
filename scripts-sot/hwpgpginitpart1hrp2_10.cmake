loadPlugin pg${DYN_LIB_EXT}
loadPlugin exception-pg${DYN_LIB_EXT}
new PatternGenerator pg

# Initialize files and information of the pattern generator.
# pg.setParamPreview ${HRP2_10-SMALL_DIRECTORY}/PreviewControlParameters.ini
pg.setVrmlDir ${HRP2_10_DATAROOTDIR}/hrp2-10-small/
pg.setVrml HRP2JRLmainSmall.wrl
pg.setXmlSpec ${HRP2_10_DATAROOTDIR}/hrp2-10-small/HRP2SpecificitiesSmall.xml
pg.setXmlRank ${HRP2_10_DATAROOTDIR}/hrp2-10-small/HRP2LinkJointRankSmall.xml




