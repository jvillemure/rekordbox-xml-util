<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="xml" version="1.0" indent="yes" />
  <xsl:strip-space elements="*"/>

  <xsl:param name="WaveBasePath" as="xs:anyURI" />
  <xsl:param name="FlacBasePath" as="xs:anyURI" />

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
    <xsl:param name="FlacElem" />

    <xsl:attribute name="Name">
      <xsl:value-of select="$FlacElem/@Name" />
    </xsl:attribute>
    <xsl:attribute
      name="Artist">
      <xsl:value-of select="$FlacElem/@Artist" />
    </xsl:attribute>
    <xsl:attribute
      name="Composer">
      <xsl:value-of select="$FlacElem/@Composer" />
    </xsl:attribute>
    <xsl:attribute
      name="Album">
      <xsl:value-of select="$FlacElem/@Album" />
    </xsl:attribute>
    <xsl:attribute
      name="Grouping">
      <xsl:value-of select="$FlacElem/@Grouping" />
    </xsl:attribute>
    <xsl:attribute
      name="Genre">
      <xsl:value-of select="$FlacElem/@Genre" />
    </xsl:attribute>
    <xsl:attribute
      name="DiscNumber">
      <xsl:value-of select="$FlacElem/@DiscNumber" />
    </xsl:attribute>
    <xsl:attribute
      name="TrackNumber">
      <xsl:value-of select="$FlacElem/@TrackNumber" />
    </xsl:attribute>
    <xsl:attribute
      name="Year">
      <xsl:value-of select="$FlacElem/@Year" />
    </xsl:attribute>
    <xsl:attribute
      name="AverageBpm">
      <xsl:value-of select="$FlacElem/@AverageBpm" />
    </xsl:attribute>
    <xsl:attribute
      name="Comments">
      <xsl:value-of select="$FlacElem/@Comments" />
    </xsl:attribute>
    <xsl:attribute
      name="Rating">
      <xsl:value-of select="$FlacElem/@Rating" />
    </xsl:attribute>
    <xsl:attribute
      name="Remixer">
      <xsl:value-of select="$FlacElem/@Remixer" />
    </xsl:attribute>
    <xsl:attribute
      name="Tonality">
      <xsl:value-of select="$FlacElem/@Tonality" />
    </xsl:attribute>
    <xsl:attribute
      name="Label">
      <xsl:value-of select="$FlacElem/@Label" />
    </xsl:attribute>
    <xsl:attribute
      name="Mix">
      <xsl:value-of select="$FlacElem/@Mix" />
    </xsl:attribute>

    <xsl:copy-of
      select="$FlacElem/*" />
  </xsl:template>

  <xsl:template match="TRACK[@Kind='WAV File'][matches(@Location,$WaveBasePath)]">
    <xsl:variable name="FlacFile"
      select="replace(replace(@Location, $WaveBasePath, $FlacBasePath), '\.wav', '.flac')" />
    <xsl:variable name="FlacElem" select="../TRACK[@Location=$FlacFile]" />

      <xsl:if test="exists($FlacElem)">
        <xsl:copy>
          <xsl:copy-of select="@*" />
          <xsl:call-template name="TrackMetadata">
            <xsl:with-param name="FlacElem" select="$FlacElem" />
          </xsl:call-template>
        </xsl:copy>
      </xsl:if>
  </xsl:template>
</xsl:stylesheet>
