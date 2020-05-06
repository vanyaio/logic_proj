%{
 { get_new_prio = addmf(get_new_prio,'input',2,'is_rt','trapmf',[0 0 1 2]);
 %}
clc
clear
close all
prmain()

function [] = prmain()
	prio = get_prio(30, 5, 50, 50)
end

function prio = get_prio(init_prio, real_time, wait_time, io_time)
	new_prio = get_new_prio_f(init_prio, real_time, false);
	reg_prio = get_reg_prio_f(new_prio, wait_time, false);
	prio = get_full_prio_f(reg_prio, io_time, true);
end

%{
 { get_new_prio
 %}
function new_prio = get_new_prio_f(init_prio, real_time, show)
get_new_prio = newfis('get_new_prio');
get_new_prio.Rules = [];

get_new_prio = addvar(get_new_prio, 'input', 'init_prio', [0 100]);
get_new_prio = addvar(get_new_prio, 'input', 'real_time', [0 100]);
get_new_prio = addvar(get_new_prio, 'output', 'new_prio', [0 100]);

get_new_prio = addmf(get_new_prio,'input',1,'low','trapmf',[0 0 10 40]);
get_new_prio = addmf(get_new_prio,'input',1,'mid','trimf',[35 50 65]);
get_new_prio = addmf(get_new_prio,'input',1,'high','trapmf',[55 90 100 100]);

get_new_prio = addmf(get_new_prio,'input',2,'is_rt','trapmf',[0 0 10 20]);
get_new_prio = addmf(get_new_prio,'input',2,'not_rt','trapmf',[15 30 100 100 ]);

get_new_prio = addmf(get_new_prio,'output',1,'low','trapmf',[0 0 10 40]);
get_new_prio = addmf(get_new_prio,'output',1,'mid','trimf',[35 50 65]);
get_new_prio = addmf(get_new_prio,'output',1,'high','trapmf',[55 90 100 100]);

r1 = 'init_prio==low & real_time==is_rt => new_prio=mid'
r2 = 'init_prio==low & real_time==not_rt => new_prio=low'

r3 = 'init_prio==mid & real_time==is_rt => new_prio=high'
r4 = 'init_prio==mid & real_time==not_rt => new_prio=mid'

r5 = 'init_prio==high & real_time==is_rt => new_prio=high'
r6 = 'init_prio==high & real_time==not_rt => new_prio=high'

c = char(r1, r2, r3, r4, r5, r6);
get_new_prio = addrule(get_new_prio, c);
if show
	fuzzy(get_new_prio)
	plotfis(get_new_prio)
	showrule(get_new_prio)
	ruleview(get_new_prio)
end

new_prio=evalfis([init_prio, real_time], get_new_prio);
end

%{
 { get_reg prio
 %}
function reg_prio = get_reg_prio_f(prio, wait_time, show) 
get_reg_prio = newfis('get_reg_prio');
get_reg_prio.Rules = [];

get_reg_prio = addvar(get_reg_prio, 'input', 'prio', [0 100]);
get_reg_prio = addvar(get_reg_prio, 'input', 'wait_time', [0 100]);
get_reg_prio = addvar(get_reg_prio, 'output', 'reg_prio', [0 100]);

get_reg_prio = addmf(get_reg_prio,'input',1,'low','trapmf',[0 0 10 40]);
get_reg_prio = addmf(get_reg_prio,'input',1,'mid','trimf',[35 50 65]);
get_reg_prio = addmf(get_reg_prio,'input',1,'high','trapmf',[55 90 100 100]);

get_reg_prio=addmf(get_reg_prio,'input',2,'not_long','trapmf',[0 0 10 20]);
get_reg_prio = addmf(get_reg_prio,'input',2,'long','trapmf',[15 30 100 100]);

get_reg_prio = addmf(get_reg_prio,'output',1,'low','trapmf',[0 0 10 40]);
get_reg_prio = addmf(get_reg_prio,'output',1,'mid','trimf',[35 50 65]);
get_reg_prio = addmf(get_reg_prio,'output',1,'high','trimf',[55 75 95]);
get_reg_prio = addmf(get_reg_prio,'output',1,'top_high','trapmf',[90 95 100 100]);

r1 = 'prio==low & wait_time==long => reg_prio=mid'
r2 = 'prio==low & wait_time==not_long => reg_prio=low'

r3 = 'prio==mid & wait_time==long => reg_prio=high'
r4 = 'prio==mid & wait_time==not_long => reg_prio=mid'

r5 = 'prio==high & wait_time==long => reg_prio=top_high'
r6 = 'prio==high & wait_time==not_long => reg_prio=high'

c = char(r1, r2, r3, r4, r5, r6);
get_reg_prio = addrule(get_reg_prio, c);
if show
	fuzzy(get_reg_prio)
	plotfis(get_reg_prio)
	showrule(get_reg_prio)
	ruleview(get_reg_prio)
end
reg_prio=evalfis([prio, wait_time], get_reg_prio);
end

%{
 { get_full_prio
 %}
function full_prio = get_full_prio_f(reg_prio, io_time, show) 
get_full_prio = newfis('get_full_prio');
get_full_prio.Rules = [];

get_full_prio = addvar(get_full_prio, 'input', 'reg_prio', [0 100]);
get_full_prio = addvar(get_full_prio, 'input', 'io_time', [0 100]);
get_full_prio = addvar(get_full_prio, 'output', 'full_prio', [0 100]);

get_full_prio = addmf(get_full_prio,'input',1,'low','trapmf',[0 0 10 40]);
get_full_prio = addmf(get_full_prio,'input',1,'mid','trimf',[35 50 65]);
get_full_prio = addmf(get_full_prio,'input',1,'high','trimf',[55 75 95]);
get_full_prio = addmf(get_full_prio,'input',1,'top_high','trapmf',[90 95 100 100]);

get_full_prio = addmf(get_full_prio,'input',2,'not_long','trapmf',[0 0 10 20]);
get_full_prio = addmf(get_full_prio,'input',2,'long','trapmf',[15 30 100 100]);

get_full_prio = addmf(get_full_prio,'output',1,'low','trapmf',[0 0 10 40]);
get_full_prio = addmf(get_full_prio,'output',1,'mid','trimf',[35 50 65]);
get_full_prio = addmf(get_full_prio,'output',1,'high','trimf',[55 75 95]);
get_full_prio = addmf(get_full_prio,'output',1,'top_high','trapmf',[90 95 100 100]);

r1 = 'io_time==not_long & reg_prio==low => full_prio=low'
r2 = 'io_time==not_long & reg_prio==mid => full_prio=mid'
r3 = 'io_time==not_long & reg_prio==high => full_prio=high'
r4 = 'io_time==not_long & reg_prio==top_high => full_prio=top_high'

r5 = 'io_time==long & reg_prio==low => full_prio=mid'
r6 = 'io_time==long & reg_prio==mid => full_prio=high'
r7 = 'io_time==long & reg_prio==high => full_prio=top_high'
r8 = 'io_time==long & reg_prio==top_high => full_prio=top_high'

c = char(r1, r2, r3, r4, r5, r6, r7, r8);
get_full_prio = addrule(get_full_prio, c);
if show
	fuzzy(get_full_prio)
	plotfis(get_full_prio)
	showrule(get_full_prio)
	ruleview(get_full_prio)
end
full_prio=evalfis([reg_prio, io_time], get_full_prio);
end
