clc
clear
close all
get_new_prio = addmf(get_new_prio,'input',2,'is_rt','trapmf',[0 0 1 2]);
%{
 { get_new_prio
 %}
get_new_prio = newfis('get_new_prio');
get_new_prio.Rules = [];

get_new_prio = addvar(get_new_prio, 'input', 'init_prio', [0 100]);
get_new_prio = addvar(get_new_prio, 'input', 'real_time', [0 100]);
get_new_prio = addvar(get_new_prio, 'output', 'new_prio', [0 100]);

get_new_prio = addmf(get_new_prio,'input',1,'low','trimf',[0 2 40]);
get_new_prio = addmf(get_new_prio,'input',1,'mid','trimf',[35 50 60]);
get_new_prio = addmf(get_new_prio,'input',1,'high','trimf',[55 80 100]);

get_new_prio = addmf(get_new_prio,'input',2,'is_rt','trapmf',[0 0 1 2]);
get_new_prio = addmf(get_new_prio,'input',2,'not_rt','trapmf',[1 5 50 54]);

get_new_prio = addmf(get_new_prio,'output',1,'low','trimf',[0 2 40]);
get_new_prio = addmf(get_new_prio,'output',1,'mid','trimf',[35 50 60]);
get_new_prio = addmf(get_new_prio,'output',1,'high','trimf',[55 80 100]);

r1 = 'init_prio==low & real_time==is_rt => new_prio=mid'
r2 = 'init_prio==low & real_time==not_rt => new_prio=low'

r3 = 'init_prio==mid & real_time==is_rt => new_prio=high'
r4 = 'init_prio==mid & real_time==not_rt => new_prio=mid'

r5 = 'init_prio==high & real_time==is_rt => new_prio=high'
r6 = 'init_prio==high & real_time==not_rt => new_prio=high'

c = char(r1, r2, r3, r4, r5, r6);
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

get_reg_prio = addmf(get_reg_prio,'input',1,'low','trimf',[0 2 40]);
get_reg_prio = addmf(get_reg_prio,'input',1,'mid','trimf',[35 50 60]);
get_reg_prio = addmf(get_reg_prio,'input',1,'high','trimf',[55 80 100]);

get_reg_prio = addmf(get_reg_prio,'input',2,'not_long','trapmf',[0 0 1 2]);
get_reg_prio = addmf(get_reg_prio,'input',2,'long','trimf',[50 60 100 100]);

get_reg_prio = addmf(get_reg_prio,'output',1,'low','trimf',[0 2 40]);
get_reg_prio = addmf(get_reg_prio,'output',1,'mid','trimf',[35 50 60]);
get_reg_prio = addmf(get_reg_prio,'output',1,'high','trimf',[55 80 100]);
get_reg_prio = addmf(get_reg_prio,'output',1,'top_high','trimf',[55 80 100]);

r1 = 'prio==low & wait_time==long => reg_prio=mid'
r2 = 'prio==low & wait_time==not_long => reg_prio=low'

r3 = 'prio==mid & wait_time==long => reg_prio=high'
r4 = 'prio==mid & wait_time==not_long => reg_prio=mid'

r5 = 'prio==high & wait_time==long => reg_prio=top_high'
r6 = 'prio==high & wait_time==not_long => reg_prio=high'

c = char(r1, r2, r3, r4, r5, r6);
get_new_prio = addrule(get_reg_prio, c);
fuzzy(get_reg_prio)
plotfis(get_reg_prio)
showrule(get_reg_prio)
ruleview(get_reg_prio)
test=evalfis([10, 50], get_reg_prio)

%{
 { get_full_prio
 %}
get_full_prio = newfis('get_full_prio');
get_full_prio.Rules = [];

get_full_prio = addvar(get_full_prio, 'input', 'reg_prio', [0 100]);
get_full_prio = addvar(get_full_prio, 'input', 'io_time', [0 100]);
get_full_prio = addvar(get_full_prio, 'output', 'full_prio', [0 100]);

get_full_prio = addmf(get_full_prio,'input',1,'low','trimf',[0 2 40]);
get_full_prio = addmf(get_full_prio,'input',1,'mid','trimf',[35 50 60]);
get_full_prio = addmf(get_full_prio,'input',1,'high','trimf',[55 80 100]);
get_full_prio = addmf(get_full_prio,'input',1,'top_high','trimf',[55 80 100]);

get_full_prio = addmf(get_full_prio,'input',2,'not_long','trimf',[0 2 40]);
get_full_prio = addmf(get_full_prio,'input',2,'long','trimf',[35 50 60]);

get_full_prio = addmf(get_full_prio,'output',1,'low','trimf',[0 2 40]);
get_full_prio = addmf(get_full_prio,'output',1,'mid','trimf',[35 50 60]);
get_full_prio = addmf(get_full_prio,'output',1,'high','trimf',[55 80 100]);
get_full_prio = addmf(get_full_prio,'output',1,'top_high','trimf',[55 80 100]);

r1 = 'io_time==not_long & reg_prio==low => full_prio=low'
r2 = 'io_time==not_long & reg_prio==mid => full_prio=mid'
r3 = 'io_time==not_long & reg_prio==high => full_prio=high'
r4 = 'io_time==not_long & reg_prio==top_high => full_prio=top_high'

r5 = 'io_time==long & reg_prio==low => full_prio=mid'
r6 = 'io_time==long & reg_prio==mid => full_prio=high'
r5 = 'io_time==long & reg_prio==high => full_prio=top_high'
r6 = 'io_time==long & reg_prio==top_high => full_prio=top_high'
