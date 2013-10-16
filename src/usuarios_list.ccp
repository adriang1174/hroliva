<Page id="1" templateExtension="html" relativePath="." fullRelativePath="." secured="True" urlType="Relative" isIncluded="False" SSLAccess="False" isService="False" cachingEnabled="False" cachingDuration="1 minutes" wizardTheme="Simple" wizardThemeVersion="3.0" needGeneration="0">
	<Components>
		<Grid id="2" secured="False" sourceType="Table" returnValueType="Number" defaultPageSize="20" name="usuarios" connection="Connection1" pageSizeLimit="100" wizardCaption=" Usuarios Lista de" wizardGridType="Tabular" wizardAllowSorting="True" wizardSortingType="SimpleDir" wizardUsePageScroller="True" wizardAllowInsert="True" wizardAltRecord="False" wizardRecordSeparator="False" wizardAltRecordType="Controls" dataSource="usuarios">
			<Components>
				<Link id="4" visible="Yes" fieldSourceType="DBColumn" dataType="Text" html="False" hrefType="Page" urlType="Relative" preserveParameters="GET" name="usuarios_Insert" hrefSource="usuarios_maint.ccp" removeParameters="idlogin" wizardThemeItem="NavigatorLink" wizardDefaultValue="Agregar Nuevo" parentName="usuarios" PathID="usuariosusuarios_Insert">
					<Components/>
					<Events/>
					<LinkParameters/>
					<Attributes/>
					<Features/>
				</Link>
				<Sorter id="5" visible="True" name="Sorter_idlogin" column="idlogin" wizardCaption="Idlogin" wizardSortingType="SimpleDir" wizardControl="idlogin" wizardAddNbsp="False" PathID="usuariosSorter_idlogin">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Sorter>
				<Sorter id="6" visible="True" name="Sorter_password" column="password" wizardCaption="Password" wizardSortingType="SimpleDir" wizardControl="password" wizardAddNbsp="False" PathID="usuariosSorter_password">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Sorter>
				<Sorter id="7" visible="True" name="Sorter_idPerfil" column="idPerfil" wizardCaption="Id Perfil" wizardSortingType="SimpleDir" wizardControl="idPerfil" wizardAddNbsp="False" PathID="usuariosSorter_idPerfil">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Sorter>
				<Sorter id="8" visible="True" name="Sorter_login" column="login" wizardCaption="Login" wizardSortingType="SimpleDir" wizardControl="login" wizardAddNbsp="False" PathID="usuariosSorter_login">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Sorter>
				<Link id="10" visible="Yes" fieldSourceType="DBColumn" dataType="Integer" html="False" hrefType="Page" urlType="Relative" preserveParameters="GET" name="idlogin" fieldSource="idlogin" wizardCaption="Idlogin" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardAddNbsp="True" wizardAlign="right" hrefSource="usuarios_maint.ccp" parentName="usuarios" rowNumber="1" PathID="usuariosidlogin">
					<Components/>
					<Events/>
					<LinkParameters>
						<LinkParameter id="11" sourceType="DataField" format="yyyy-mm-dd" name="idlogin" source="idlogin"/>
					</LinkParameters>
					<Attributes/>
					<Features/>
				</Link>
				<Label id="13" fieldSourceType="DBColumn" dataType="Text" html="False" name="password" fieldSource="password" wizardCaption="Password" wizardSize="20" wizardMaxLength="20" wizardIsPassword="False" wizardAddNbsp="True" parentName="usuarios" rowNumber="1" PathID="usuariospassword">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Label>
				<Label id="15" fieldSourceType="DBColumn" dataType="Integer" html="False" name="idPerfil" fieldSource="idPerfil" wizardCaption="Id Perfil" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardAddNbsp="True" wizardAlign="right" parentName="usuarios" rowNumber="1" PathID="usuariosidPerfil">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Label>
				<Label id="17" fieldSourceType="DBColumn" dataType="Text" html="False" name="login" fieldSource="login" wizardCaption="Login" wizardSize="20" wizardMaxLength="20" wizardIsPassword="False" wizardAddNbsp="True" parentName="usuarios" rowNumber="1" PathID="usuarioslogin">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Label>
				<Navigator id="18" size="10" type="Simple" pageSizes="1;5;10;25;50" name="Navigator" wizardFirst="True" wizardPrev="True" wizardFirstText="|&lt;" wizardPrevText="&lt;&lt;" wizardNextText="&gt;&gt;" wizardLastText="&gt;|" wizardNext="True" wizardLast="True" wizardPageNumbers="Simple" wizardSize="10" wizardTotalPages="True" wizardHideDisabled="True" wizardOfText="de" wizardImagesScheme="Simple">
					<Components/>
					<Events>
						<Event name="BeforeShow" type="Server">
							<Actions>
								<Action actionName="Hide-Show Component" actionCategory="General" id="19" action="Hide" conditionType="Parameter" dataType="Integer" condition="LessThan" name1="TotalPages" sourceType1="SpecialValue" name2="2" sourceType2="Expression"/>
							</Actions>
						</Event>
					</Events>
					<Attributes/>
					<Features/>
				</Navigator>
			</Components>
			<Events/>
			<TableParameters/>
			<JoinTables>
				<JoinTable id="3" tableName="usuarios" posWidth="-1" posHeight="-1" posLeft="-1" posRight="-1"/>
			</JoinTables>
			<JoinLinks/>
			<Fields>
				<Field id="9" tableName="usuarios" fieldName="idlogin"/>
				<Field id="12" tableName="usuarios" fieldName="password"/>
				<Field id="14" tableName="usuarios" fieldName="idPerfil"/>
				<Field id="16" tableName="usuarios" fieldName="login"/>
			</Fields>
			<SPParameters/>
			<SQLParameters/>
			<SecurityGroups/>
			<Attributes/>
			<Features/>
		</Grid>
	</Components>
	<CodeFiles>
		<CodeFile id="Events" language="PHPTemplates" name="usuarios_list_events.php" forShow="False" comment="//" codePage="windows-1252"/>
		<CodeFile id="Code" language="PHPTemplates" name="usuarios_list.php" forShow="True" url="usuarios_list.php" comment="//" codePage="windows-1252"/>
		<CodeFile id="Events" language="ASPTemplates" name="usuarios_list_events.asp" forShow="False" comment="'" codePage="windows-1252"/>
<CodeFile id="Code" language="ASPTemplates" name="usuarios_list.asp" forShow="True" url="usuarios_list.asp" comment="'" codePage="windows-1252"/>
</CodeFiles>
	<SecurityGroups>
		<Group id="20" groupID="100"/>
	</SecurityGroups>
	<CachingParameters/>
	<Attributes/>
	<Features/>
	<Events/>
</Page>
