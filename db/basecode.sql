select * from BZ_XTDM_T
insert into BZ_XTDM_T(id,dmmc,dmlm,dmmc_en) values(1,'分析阶段','org.expr.model.basecode.AnalysisPhase','AnalysisPhase');
insert into BZ_XTDM_T(id,dmmc,dmlm,dmmc_en) values(2,'资产项目','org.expr.model.basecode.AssetProject','AssetProject');
insert into BZ_XTDM_T(id,dmmc,dmlm,dmmc_en) values(3,'支出项目','org.expr.model.basecode.ExpendProject','ExpendProject');
insert into BZ_XTDM_T(id,dmmc,dmlm,dmmc_en) values(4,'实验类型','org.expr.model.basecode.ExperimentType','ExperimentType');
insert into BZ_XTDM_T(id,dmmc,dmlm,dmmc_en) values(5,'收入项目','org.expr.model.basecode.IncomeProject','IncomeProject');
insert into BZ_XTDM_T(id,dmmc,dmlm,dmmc_en) values(6,'负债项目','org.expr.model.basecode.LiabilityProject','LiabilityProject');
insert into BZ_XTDM_T(id,dmmc,dmlm,dmmc_en) values(7,'生命周期类型','org.expr.model.basecode.LifeCycleType','LifeCycleType');
insert into BZ_XTDM_T(id,dmmc,dmlm,dmmc_en) values(8,'风险承受态度','org.expr.model.basecode.RiskBearAttitude','RiskBearAttitude');
insert into BZ_XTDM_T(id,dmmc,dmlm,dmmc_en) values(9,'理财工具','org.expr.model.basecode.FinanceTool','FinanceTool');
insert into BZ_XTDM_T(id,dmmc,dmlm,dmmc_en) values(10,'理财工具种类','org.expr.model.basecode.FinanceToolCategory','FinanceToolCategory');


insert into BZ_XTDM_T(id,dmmc,dmlm,dmmc_en) values(11,'理财产品','org.expr.model.basecode.FinanceProduct','FinanceProduct');
insert into BZ_XTDM_T(id,dmmc,dmlm,dmmc_en) values(12,'理财产品种类','org.expr.model.basecode.FinanceProductCategory','FinanceProductCategory');


insert into xb_student_types (id,code,name ,created_at,updated_at,enabled) values (1,'01','本科生',sysdate,sysdate,1);
--insert into xb_education_types (id,code,name ,created_at,updated_at,enabled,minor) values (1,'01','本科生',sysdate,sysdate,1,1);
--insert into kc_t (id,kcdm,kcmc ,zdsj,xgsj,sfky,sfyq,xslbid,pylxid,xf) values (1,'111','保险规划',sysdate,sysdate,1,1,1,1,2);
insert into lessons (id,seq_no,course_id) values (1,'0001',1);
insert into lessons (id,seq_no,course_id) values (2,'0002',1);



insert into work_categories(id,code,name,created_at,updated_at,enabled,parent_id,category_level)
values(1,'00','一般职业',current_time,current_time,1,null,null)

insert into work_categories(id,code,name,created_at,updated_at,enabled,parent_id,category_level)
values(2,'0001','机关团体公司及事业单位',current_time,current_time,1,1,null)

insert into work_categories(id,code,name,created_at,updated_at,enabled,parent_id,category_level)
values(3,'0001001','内勤人员',current_time,current_time,1,2,null)

insert into work_categories(id,code,name,created_at,updated_at,enabled,parent_id,category_level)
values(4,'0001002','外勤人员',current_time,current_time,1,2,1)

insert into work_categories(id,code,name,created_at,updated_at,enabled,parent_id,category_level)
values(5,'0002','工厂',current_time,current_time,1,1,null)


insert into work_categories(id,code,name,created_at,updated_at,enabled,parent_id,category_level)
values(6,'0002001','负责人',current_time,current_time,1,5,1)


alter table liability_projects drop constraint  FK4CC376C2F34FAF5 ;
update liability_projects set parent_id=8 where id=5;
update liability_projects set parent_id=8 where id=6;
update liability_projects set parent_id=8 where id=7;

update liability_projects set parent_id=13 where id=9;
update liability_projects set parent_id=13 where id=10;
update liability_projects set parent_id=13 where id=11;
update liability_projects set parent_id=13 where id=12;

update income_projects set parent_id=8 where id=5;
update income_projects set parent_id=8 where id=6;
update income_projects set parent_id=8 where id=7;