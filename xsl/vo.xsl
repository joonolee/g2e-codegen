<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="UTF-8" />
<xsl:variable name="vLower" select="'abcdefghijklmnopqrstuvwxyz'"/>
<xsl:variable name="vUpper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
<xsl:template match="table">
package com.crud;

import java.io.Serializable;
import java.math.*;
import java.util.*;
import javax.persistence.*;
import org.hibernate.annotations.DynamicUpdate;
import lombok.*;
<xsl:if test='count(columns/column[@primarykey]) > 1'>
@IdClass(<xsl:value-of select='translate(@class, $vLower, $vUpper)'/>VO.PK.class)</xsl:if>
@Getter
@Setter
@ToString
@Entity
@DynamicUpdate
@Table(name = "<xsl:value-of select='@name'/>")
public class <xsl:value-of select='translate(@class, $vLower, $vUpper)'/>VO {
<xsl:for-each select="columns/column[@primarykey]">
	<xsl:if test="@auto_increment">
	@GeneratedValue(strategy = GenerationType.IDENTITY)</xsl:if>
	@Id
	private <xsl:value-of select='@type'/><xsl:text> </xsl:text><xsl:value-of select='@name'/>;
</xsl:for-each>
<xsl:for-each select="columns/column[not(@primarykey)]">
	@Column<xsl:if test="@insert='none'">(insertable = false)</xsl:if><xsl:if test="@update='none'">(updatable = false)</xsl:if>
	private <xsl:value-of select='@type'/><xsl:text> </xsl:text><xsl:value-of select='@name'/>;
</xsl:for-each>

<xsl:if test='count(columns/column[@primarykey]) > 1'>
	@NoArgsConstructor
	@AllArgsConstructor
	@EqualsAndHashCode
	@ToString
	public static class PK implements Serializable {<xsl:for-each select="columns/column[@primarykey]">
		private <xsl:value-of select='@type'/><xsl:text> </xsl:text><xsl:value-of select='@name'/>;</xsl:for-each>	
	}
</xsl:if>
}
</xsl:template>
</xsl:stylesheet>