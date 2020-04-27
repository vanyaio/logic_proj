clc
clear
close all
%{
 { get_new_prio
 %}
get_new_prio = newfis('get_new_prio');
get_new_prio.Rules = [];

get_new_prio = addvar(get_new_prio, 'input', 'init_prio', [0 100]);
get_new_prio = addvar(get_new_prio, 'input', 'exec_time', [0 100]);
get_new_prio = addvar(get_new_prio, 'output', 'new_prio', [0 100]);

%{
 { seems bad
 %}
get_new_prio = addmf(get_new_prio,'input',1,'low','trimf',[0 2 40]);
get_new_prio = addmf(get_new_prio,'input',1,'mid','trimf',[35 50 60]);
get_new_prio = addmf(get_new_prio,'input',1,'high','trimf',[55 80 100]);

get_new_prio = addmf(get_new_prio,'input',2,'quick','trapmf',[0 0 1 2]);
get_new_prio = addmf(get_new_prio,'input',2,'mid','trapmf',[1 5 50 54]);
get_new_prio = addmf(get_new_prio,'input',2,'long','trapmf',[50 60 100 100]);

%{
 { seems bad
 %}
get_new_prio = addmf(get_new_prio,'output',1,'low','trimf',[0 2 40]);
get_new_prio = addmf(get_new_prio,'output',1,'mid','trimf',[35 50 60]);
get_new_prio = addmf(get_new_prio,'output',1,'high','trimf',[55 80 100]);

r1 = 'init_prio==low & exec_time==quick => new_prio=high'
r2 = 'init_prio==low & exec_time==mid => new_prio=mid'
r3 = 'init_prio==low & exec_time==long => new_prio=low'

r4 = 'init_prio==mid & exec_time==quick => new_prio=high'
r5 = 'init_prio==mid & exec_time==mid => new_prio=low'
r6 = 'init_prio==mid & exec_time==long => new_prio=low'

r4 = 'init_prio==high & exec_time==quick => new_prio=low'
r5 = 'init_prio==high & exec_time==mid => new_prio=low'
r6 = 'init_prio==high & exec_time==long => new_prio=low'

c = char(r1, r2, r3);
get_new_prio = addrule(get_new_prio, c);
fuzzy(get_new_prio)
plotfis(get_new_prio)
showrule(get_new_prio)
ruleview(get_new_prio)
test=evalfis([10, 50], get_new_prio)

%{
 { get_reg prio
 %}
get_reg_prio = newfis('get_reg_prio');
get_reg_prio.Rules = [];

get_reg_prio = addvar(get_reg_prio, 'input', 'prio', [0 100]);
get_reg_prio = addvar(get_reg_prio, 'input', 'wait_time', [0 100]);
get_reg_prio = addvar(get_reg_prio, 'output', 'reg_prio', [0 100]);

%{
 { seems bad
 %}
get_reg_prio = addmf(get_reg_prio,'input',1,'low','trimf',[0 2 40]);
get_reg_prio = addmf(get_reg_prio,'input',1,'mid','trimf',[35 50 60]);
get_reg_prio = addmf(get_reg_prio,'input',1,'high','trimf',[55 80 100]);

get_reg_prio = addmf(get_reg_prio,'input',2,'quick','trapmf',[0 0 1 2]);
get_reg_prio = addmf(get_reg_prio,'input',2,'mid','trimf',[1 5 50 54]);
get_reg_prio = addmf(get_reg_prio,'input',2,'long','trimf',[50 60 100 100]);

%{
 { seems bad
 %}
get_reg_prio = addmf(get_reg_prio,'output',1,'low','trimf',[0 2 40]);
get_reg_prio = addmf(get_reg_prio,'output',1,'mid','trimf',[35 50 60]);
get_reg_prio = addmf(get_reg_prio,'output',1,'high','trimf',[55 80 100]);



%{
 { get_io_prio
 %}
get_io_prio = newfis('get_io_prio');
get_io_prio.Rules = [];

get_io_prio = addvar(get_io_prio, 'input', 'finished_io', [0 100]);
get_io_prio = addvar(get_io_prio, 'input', 'io_time', [0 100]);
get_io_prio = addvar(get_io_prio, 'output', 'io_prio', [0 100]);

%{
 { get_full_prio
 %}
get_full_prio = newfis('get_full_prio');
get_full_prio.Rules = [];

get_full_prio = addvar(get_full_prio, 'input', 'reg_prio', [0 100]);
get_full_prio = addvar(get_full_prio, 'input', 'io_prio', [0 100]);
get_full_prio = addvar(get_full_prio, 'output', 'full_prio', [0 100]);
