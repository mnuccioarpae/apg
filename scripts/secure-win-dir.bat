

echo ####################### BigSQL (c) 2019 ##########################

set p_dir=%1
set p_is_exe=%2
set p_user=%3

if ["%p_dir%"] == [""] goto usage
if ["%p_is_exe%"] == [""] goto usage
if ["%p_user%"] == [""] goto usage

mkdir %p_dir%

takeown /F "%p_dir%" /R /D Y > nul

set icacls_cmd=icacls "%p_dir%" /t /c /q 
%icacls_cmd% /reset
icacls %p_dir%

set g_system="*S-1-5-18":"F"
set g_admins="*S-1-5-32-544":"F"
set g_user="%p_user%":"F"
%icacls_cmd%  /inheritancelevel:r /grant:r %g_system% /grant %g_admins% /grant %g_user%

if ["%p_is_exe%"] == [""False""] goto end
set g_authenticated_users="*S-1-5-11":"RX"
%icacls_cmd% /grant %g_authenticated_users%

goto end

:usage
echo ERROR: Invalid command line args.  Must be 3 parms.
  
:end
icacls %p_dir%
exit
