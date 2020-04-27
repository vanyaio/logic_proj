clc
clear
close all
pr_dm_fis=newfis('Price-Demand');
pr_dm_fis.Rules = [];
pr_dm_fis = addvar(pr_dm_fis,'input','price',[10 90]);
pr_dm_fis = addvar(pr_dm_fis,'output','demand',[0 100]);
pr_dm_fis = addmf(pr_dm_fis,'input',1,'cheap','trimf',[18 28 33]);
pr_dm_fis = addmf(pr_dm_fis,'input',1,'medium','trimf',[30 35 40]);
pr_dm_fis = addmf(pr_dm_fis,'input',1,'expensive','trimf',[40 70 90]);
pr_dm_fis = addmf(pr_dm_fis,'output',1,'low','trimf',[0 20 40]);
pr_dm_fis = addmf(pr_dm_fis,'output',1,'mid','trimf',[30 40 60]);
pr_dm_fis = addmf(pr_dm_fis,'output',1,'high','trimf',[50 80 100]);
%{
 { Fuzzy_rules=[1 3 1 1
 {     3 1 1 1
 {     2 2 1 1];
 %}
r1 = 'price==cheap => demand==high';
r2 = 'price==expensive => demand==low';
r3 = 'price==medium => demand==mid';

Fuzzy_rules = [r1 r2];
%{
 { Fuzzy_rules = [r1 r2 r3];
 %}
pr_dm_fis = addrule(pr_dm_fis,char(r1, r2, r3));
%{
 { pr_dm_fis = addrule(pr_dm_fis,Fuzzy_rules);
 %}
fuzzy(pr_dm_fis)
plotfis(pr_dm_fis)
showrule(pr_dm_fis)
ruleview(pr_dm_fis)

test=evalfis([30], pr_dm_fis)
%{
 { Fuzzy_rules = [r1];
 %}
