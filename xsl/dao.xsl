<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:output method="text"  encoding="UTF-8" />
<xsl:variable name="vLower" select="'abcdefghijklmnopqrstuvwxyz'"/>
<xsl:variable name="vUpper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
<xsl:template match="table">package com.crud;

import org.springframework.data.jpa.repository.JpaRepository;
import java.math.*;
import java.util.*;

public interface <xsl:value-of select='translate(@class, $vLower, $vUpper)'/>DAO extends JpaRepository&lt;<xsl:value-of select="translate(@class, $vLower, $vUpper)"/>VO, <xsl:if test='count(columns/column[@primarykey])=1'><xsl:value-of select='columns/column[@primarykey]/@type'/></xsl:if>
<xsl:if test='count(columns/column[@primarykey])>1'><xsl:value-of select='translate(@class, $vLower, $vUpper)'/>VO.PK</xsl:if>&gt; {
}</xsl:template>
</xsl:stylesheet>