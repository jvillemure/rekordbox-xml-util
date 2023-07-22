<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="xml" version="1.0" indent="yes" />
  <xsl:strip-space elements="*"/>

  <xsl:param name="WaveBasePath" as="xs:string" />
  <xsl:param name="FlacBasePath" as="xs:string" />

  <xsl:template match="/DJ_PLAYLISTS">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="PRODUCT" />
      <xsl:apply-templates select="COLLECTION" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="COLLECTION">
    <xsl:copy>
      <xsl:attribute name="Entries">
        <xsl:value-of select="count(TRACK[@Kind='WAV File'][matches(@Location,$WaveBasePath)])" />
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>

  <xsl:template name="TrackMetadata">
    <xsl:param name="FlacFile" />

    <xsl:attribute name="Name">
      <xsl:value-of select="$FlacFile/@Name" />
    </xsl:attribute>
    <xsl:attribute
      name="Artist">
      <xsl:value-of select="$FlacFile/@Artist" />
    </xsl:attribute>
    <xsl:attribute
      name="Composer">
      <xsl:value-of select="$FlacFile/@Composer" />
    </xsl:attribute>
    <xsl:attribute
      name="Album">
      <xsl:value-of select="$FlacFile/@Album" />
    </xsl:attribute>
    <xsl:attribute
      name="Grouping">
      <xsl:value-of select="$FlacFile/@Grouping" />
    </xsl:attribute>
    <xsl:attribute
      name="Genre">
      <xsl:value-of select="$FlacFile/@Genre" />
    </xsl:attribute>
    <xsl:attribute
      name="DiscNumber">
      <xsl:value-of select="$FlacFile/@DiscNumber" />
    </xsl:attribute>
    <xsl:attribute
      name="TrackNumber">
      <xsl:value-of select="$FlacFile/@TrackNumber" />
    </xsl:attribute>
    <xsl:attribute
      name="Year">
      <xsl:value-of select="$FlacFile/@Year" />
    </xsl:attribute>
    <xsl:attribute
      name="AverageBpm">
      <xsl:value-of select="$FlacFile/@AverageBpm" />
    </xsl:attribute>
    <xsl:attribute
      name="Comments">
      <xsl:value-of select="$FlacFile/@Comments" />
    </xsl:attribute>
    <xsl:attribute
      name="Rating">
      <xsl:value-of select="$FlacFile/@Rating" />
    </xsl:attribute>
    <xsl:attribute
      name="Remixer">
      <xsl:value-of select="$FlacFile/@Remixer" />
    </xsl:attribute>
    <xsl:attribute
      name="Tonality">
      <xsl:value-of select="$FlacFile/@Tonality" />
    </xsl:attribute>
    <xsl:attribute
      name="Label">
      <xsl:value-of select="$FlacFile/@Label" />
    </xsl:attribute>
    <xsl:attribute
      name="Mix">
      <xsl:value-of select="$FlacFile/@Mix" />
    </xsl:attribute>

    <xsl:copy-of
      select="$FlacFile/*" />
  </xsl:template>

  <xsl:template match="TRACK[@Kind='WAV File'][matches(@Location,$WaveBasePath)]">
    <xsl:variable name="FileKey"
      select="replace(replace(@Location, $WaveBasePath, $FlacBasePath), '\.wav', '.flac')" />
      <!-- <xsl:if test="$FlacFile != ''" ></xsl:if> -->

    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:call-template name="TrackMetadata">
        <xsl:with-param name="FlacFile" select="../TRACK[@Location=$FileKey]" />
      </xsl:call-template>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
