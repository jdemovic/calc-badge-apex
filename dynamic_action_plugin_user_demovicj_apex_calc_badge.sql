set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050000 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2013.01.01'
,p_release=>'5.0.1.00.06'
,p_default_workspace_id=>1313320725375666
,p_default_application_id=>30000
,p_default_owner=>'AEGAPPS'
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/dynamic_action/user_demovicj_apex_calc_badge
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(15201703445237197)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'USER.DEMOVICJ.APEX.CALC_BADGE'
,p_display_name=>'CalcBadge - APEX5(1.0)'
,p_category=>'COMPONENT'
,p_supported_ui_types=>'DESKTOP'
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'function ajax    ( p_dynamic_action  apex_plugin.t_dynamic_action',
'                  ,p_plugin          apex_plugin.t_plugin)',
'  return apex_plugin.t_dynamic_action_ajax_result',
'is  ',
'    l_statement           varchar2(32767) := p_dynamic_action.attribute_01;',
'    l_page_item_to_submit varchar2(32767) := p_dynamic_action.attribute_02;',
'    l_selector            varchar2(32767) := p_dynamic_action.attribute_03;',
'    l_badge_id            varchar2(32767) := replace(replace(replace(p_dynamic_action.attribute_03, ''#'',''''), ''.'',''''),'' '','''');',
'    l_offset              number := p_dynamic_action.attribute_04;',
'    l_top                 number := p_dynamic_action.attribute_05;',
'    l_cursor              number;',
'    l_value               varchar2(4000);',
'    l_name_list           sys.dbms_sql.varchar2_table;',
'    l_dummy               number;',
'    l_return_value        varchar2(32767);',
'begin',
'  --',
'  -- We can''t use EXECUTE IMMEDIATE or OPEN FOR here, because we don''t know',
'    -- at design time how many bind variables the statement will contain.',
'    -- That''s why we have to use DBMS_SQL which provides a more flexible',
'    -- interface.',
'    l_cursor := sys.dbms_sql.open_cursor;',
'    -- First do a parse to verify if the statement works',
'    sys.dbms_sql.parse (',
'        c             => l_cursor,',
'        statement     => replace(replace(l_statement, chr(13), '' ''),'';'',''''),',
'        language_flag => sys.dbms_sql.native );',
'    -- We are just interested in the first column of our statement',
'    sys.dbms_sql.define_column(l_cursor, 1, l_value, 4000);',
'',
'    -- Bind all session state references eg. :P7_CATEGORY',
'    l_name_list := wwv_flow_utilities.get_binds(l_statement);',
'    -- bind each found page item with the value in session state',
'    for i in 1 .. l_name_list.count',
'    loop',
'        sys.dbms_sql.bind_variable(l_cursor, l_name_list(i), v(substr(l_name_list(i), 2)), 32000);',
'    end loop;',
'',
'    -- Execute statement!',
'    l_dummy := sys.dbms_sql.execute(l_cursor);',
'    -- If the SQL statement returns multiple rows then we will concatenate them',
'    -- to one string',
'    while sys.dbms_sql.fetch_rows(l_cursor) > 0',
'    loop',
'        dbms_sql.column_value(l_cursor, 1, l_value);',
'        l_return_value := l_return_value||',
'                          case when l_return_value is not null then '','' end||',
'                          l_value;',
'    end loop;',
'    --',
'    sys.dbms_sql.close_cursor(l_cursor);',
'    -- create JSON object with necessary properties',
'    htp.p(''{"badge":"''||l_return_value||''","selector":"''||l_selector||''","badge_id":"''||l_badge_id||''","l_offset":''||l_offset||'',"l_top":''||l_top||''}'');',
'    --',
'  return null;',
'EXCEPTION',
'  when OTHERS then',
'    raise;',
'end ajax;',
'',
'function render(p_dynamic_action in apex_plugin.t_dynamic_action',
'               ,p_plugin         in apex_plugin.t_plugin)',
'return apex_plugin.t_dynamic_action_render_result is',
'    l_render_result apex_plugin.t_dynamic_action_render_result;',
'    l_page_item_to_submit     varchar2(32767) := p_dynamic_action.attribute_02;',
'begin',
'  --',
'  apex_javascript.add_library (',
'        p_name      => ''calc.badge'',',
'        p_directory => p_plugin.file_prefix,',
'        p_version   => null );',
'  APEX_CSS.ADD_FILE (',
'        p_name      => ''badge'',',
'        p_directory => p_plugin.file_prefix,',
'        p_version   => null );',
'        ',
'  l_render_result.javascript_function := ''user_demovicj_calc_badge'';',
'  l_render_result.ajax_identifier     := apex_plugin.get_ajax_identifier;',
'  l_render_result.attribute_01        := l_page_item_to_submit;',
'  ',
'  return l_render_result;',
'end render;'))
,p_render_function=>'render'
,p_ajax_function=>'ajax'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
,p_files_version=>9
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(15202464129305273)
,p_plugin_id=>wwv_flow_api.id(15201703445237197)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'SQL Query'
,p_attribute_type=>'SQL'
,p_is_required=>true
,p_default_value=>'select count(*) from dual;'
,p_sql_min_column_count=>1
,p_sql_max_column_count=>1
,p_is_translatable=>false
,p_help_text=>'SQL query to return one number value shown in affected element defined by jQuery selector.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(15202773029318728)
,p_plugin_id=>wwv_flow_api.id(15201703445237197)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Paege Items To Submit'
,p_attribute_type=>'PAGE ITEMS'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>'Items which will be submitted when sql query is processed.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8538398444895836)
,p_plugin_id=>wwv_flow_api.id(15201703445237197)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'jQuery selector'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'#item_id'
,p_is_translatable=>false
,p_help_text=>'Insert jQuery selector for item where badge will be shown.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8559369550436273)
,p_plugin_id=>wwv_flow_api.id(15201703445237197)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Left Offset'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'6'
,p_is_translatable=>false
,p_help_text=>'Left offset from DOM width to the right.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8567217231446817)
,p_plugin_id=>wwv_flow_api.id(15201703445237197)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Top'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'5'
,p_is_translatable=>false
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E6261646765207B0A202020206261636B67726F756E643A207265642072616469616C2D6772616469656E7428636972636C6520617420357078202D397078202C2077686974652038252C2072656420323670782920726570656174207363726F6C6C20';
wwv_flow_api.g_varchar2_table(2) := '3020303B0A20202020626F726465723A2032707820736F6C69642077686974653B0A20202020626F726465722D7261646975733A20313270783B0A20202020626F782D736861646F773A20317078203170782031707820626C61636B3B0A20202020636F';
wwv_flow_api.g_varchar2_table(3) := '6C6F723A2077686974653B0A20202020666F6E743A20626F6C6420313270782F3770782048656C7665746963612C56657264616E612C5461686F6D613B0A202020206865696768743A20313870783B0A202020202F2A6D696E2D77696474683A20313470';
wwv_flow_api.g_varchar2_table(4) := '783B2A2F0A2020202070616464696E673A20347078203370783B0A20202020746578742D616C69676E3A2063656E7465723B0A20202020706F736974696F6E3A206162736F6C7574653B0A202020202F2A6C6566743A20323070783B2A2F0A202020202F';
wwv_flow_api.g_varchar2_table(5) := '2A746F703A203070783B2A2F0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(8570596516695400)
,p_plugin_id=>wwv_flow_api.id(15201703445237197)
,p_file_name=>'badge.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2F20412064796E616D696320616374696F6E20706C75672D696E2066756E6374696F6E2063616E2061636365737320697427732063757272656E7420636F6E7465787420776974682074686520227468697322206F626A6563742E0A2F2F2049742063';
wwv_flow_api.g_varchar2_table(2) := '6F6E7461696E7320666F72206578616D706C652022616374696F6E222077686963682073746F726573207468652064796E616D69632061747472696275746573206174747269627574653031202D20617474726962757465313020616E640A2F2F207468';
wwv_flow_api.g_varchar2_table(3) := '6520616A61784964656E746966696572207573656420666F722074686520414A41582063616C6C2E20496E73696465207468652066756E6374696F6E20796F752063616E207573650A2F2F2022746869732E6166666563746564456C656D656E74732220';
wwv_flow_api.g_varchar2_table(4) := '746F206765742061206A5175657279206F626A65637420776869636820636F6E7461696E7320616C6C207468652061666665637465640A2F2F20444F4D20656C656D656E7473206F75722064796E616D696320616374696F6E2073686F756C6420626520';
wwv_flow_api.g_varchar2_table(5) := '706572666F726D6564206F6E2E0A2F2F0A2F2F20466F722064796E616D696320616374696F6E20706C75672D696E2066756E6374696F6E7320796F752073686F756C642075736520612066756E6374696F6E206E616D652077686963682069730A2F2F20';
wwv_flow_api.g_varchar2_table(6) := '756E697175652C20736F20697420646F65736E27742067657420696E20636F6E666C6963742077697468206578697374696E672066756E6374696F6E732E20426573742070726163746973650A2F2F20697320746F20757365207468652073616D65206E';
wwv_flow_api.g_varchar2_table(7) := '616D65206173207573656420666F722074686520706C75672D696E20696E7465726E616C206E616D652E0A0A66756E6374696F6E20757365725F64656D6F7669636A5F63616C635F62616467652829207B0A20202F2F2049742773206265747465722074';
wwv_flow_api.g_varchar2_table(8) := '6F2068617665206E616D6564207661726961626C657320696E7374656164206F66207573696E670A20202F2F207468652067656E65726963206F6E65732C2074686174206D616B65732074686520636F6465206D6F7265207265616461626C650A202076';
wwv_flow_api.g_varchar2_table(9) := '6172206C506167654974656D73546F5375626D6974203D20746869732E616374696F6E2E61747472696275746530313B0A20202F2F204275696C6420616E20414A4158207265717565737420617320796F7520776F756C6420646F20666F7220616E206F';
wwv_flow_api.g_varchar2_table(10) := '6E2D64656D616E642063616C6C2E20546865206F6E6C790A20202F2F20646966666572656E6365206973207468617420696E7374656164206F6620224150504C49434154494F4E5F50524F434553533D2220796F75206861766520746F20757365202250';
wwv_flow_api.g_varchar2_table(11) := '4C5547494E3D220A2020766172206C416A617852657175657374203D206E65772068746D6C64625F476574286E756C6C2C202476282770466C6F77496427292C2022504C5547494E3D222B746869732E616374696F6E2E616A61784964656E7469666965';
wwv_flow_api.g_varchar2_table(12) := '722C202476282770466C6F775374657049642729293B0A2020766172206C416A6178526573756C7420203D206E756C6C3B0A20202F2F205365742073657373696F6E20737461746520776974682074686520414A4158207265717565737420666F722061';
wwv_flow_api.g_varchar2_table(13) := '6C6C2070616765206974656D732077686963682061726520646566696E65640A20202F2F20696E206F7572202250616765204974656D7320746F207375626D697422206174747269627574652E20416761696E2077652063616E20757365206A51756572';
wwv_flow_api.g_varchar2_table(14) := '792E6561636820746F0A20202F2F206C6F6F70206F76657220746865206172726179206F662070616765206974656D732E0A2020696620286C506167654974656D73546F5375626D697429207B0A20206A51756572792E65616368280A202020206C5061';
wwv_flow_api.g_varchar2_table(15) := '67654974656D73546F5375626D69742E73706C697428272C27292C202F2F20746869732077696C6C2063726561746520616E2061727261790A2020202066756E6374696F6E2829207B0A202020202020766172206C506167654974656D203D2061706578';
wwv_flow_api.g_varchar2_table(16) := '2E6A5175657279282723272B74686973295B305D3B202F2F206765742074686520444F4D206F626A6563740A2020202020202F2F204F6E6C79206966207468652070616765206974656D206578697374732C2077652061646420697420746F2074686520';
wwv_flow_api.g_varchar2_table(17) := '414A415820726571756573740A202020202020696620286C506167654974656D29207B0A20202020202020206C416A6178526571756573742E61646428746869732C202476286C506167654974656D29293B207D0A202020207D293B7D0A20202F2F206C';
wwv_flow_api.g_varchar2_table(18) := '6574277320657865637574652074686520414A415820726571756573740A20206C416A6178526573756C74203D206C416A6178526571756573742E67657428293B0A20202F2F7061727365206A736F6E206F626A6563740A20206F626A203D204A534F4E';
wwv_flow_api.g_varchar2_table(19) := '2E7061727365286C416A6178526573756C74293B0A20202F2F63616C63756C617465207661726961626C65730A2020766172207020203D2024286F626A2E73656C6563746F72293B0A202076617220706F736974696F6E203D20702E706F736974696F6E';
wwv_flow_api.g_varchar2_table(20) := '28293B0A2020766172207720203D20702E77696474682829202B206F626A2E6C5F6F66667365743B0A20207661722064765F6261646765203D202762616467652D272B6F626A2E62616467655F69643B0A20202F2F72656D6F7665206261646765206372';
wwv_flow_api.g_varchar2_table(21) := '6561746564206265666F7265202D2072656672657368200A20202428276469762327202B2064765F6261646765292E72656D6F766528293B0A20202F2F61646420626164676520646976206E65787420746F206A51756572792073656C6563746F722073';
wwv_flow_api.g_varchar2_table(22) := '656C6563746564206974656D0A202024286F626A2E73656C6563746F72292E616674657228273C6469762069643D22272B64765F62616467652B272220636C6173733D22626164676522207374796C653D226C6566743A27202B2077202B202770783B74';
wwv_flow_api.g_varchar2_table(23) := '6F703A27202B206F626A2E6C5F746F70202B202770783B223E272B206F626A2E6261646765202B273C2F6469763E27293B0A7D3B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(8572055566988337)
,p_plugin_id=>wwv_flow_api.id(15201703445237197)
,p_file_name=>'calc.badge.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
