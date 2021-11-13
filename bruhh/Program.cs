using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using SharedLibraryCore;
using SharedLibraryCore.Configuration;
using SharedLibraryCore.Database.Models;
using SharedLibraryCore.Interfaces;

namespace IW4MAdmin.Plugins.testt
{
    public class Plugin : IPlugin
    {
        int heh;
        public string Name => "Testttt";

        public float Version => 1;

        public string Author => "xanderalex";

        string hm0 = "";
        string hm1 = "";
        string hm2 = "";
        string hm3 = "";
        string hm4 = "";
        string hm5 = "";
        string hm6 = "";
        string hm7 = "";
        string hm8 = "";
        string hm9 = "";
        string hm10 = "";
        string hm11 = "";
        string hm12 = "";
        string hm13 = "";
        string hm14 = "";
        string hm15 = "";
        string hm16 = "";
        string hm17 = "";
        string final;

        public Task OnEventAsync(GameEvent E, Server S)
        {
            if(E.Type == GameEvent.EventType.MapChange)
            {
                S.SetDvarAsync("xuidd", final);
            }
            if (E.Type == GameEvent.EventType.Join || E.Type == GameEvent.EventType.PreConnect)
            {
                if(E.Origin.ClientPermission.Level == EFClient.Permission.Owner || E.Origin.ClientPermission.Level == EFClient.Permission.Creator || E.Origin.ClientPermission.Level == EFClient.Permission.Moderator || E.Origin.ClientPermission.Level == EFClient.Permission.SeniorAdmin)
                {
                    string s = (E.Origin.NetworkId + 76561197960265728).ToString("X").ToLower();
                    if(hm0 == s) { return Task.CompletedTask; }
                    else if(hm0 == "") { hm0 = s; }
                    else if (hm1 == s) { return Task.CompletedTask; }
                    else if (hm1 == "") { hm1 = s; }
                    else if (hm2 == s) { return Task.CompletedTask; }
                    else if (hm2 == "") { hm2 = s; }
                    else if (hm3 == s) { return Task.CompletedTask; }
                    else if (hm3 == "") { hm3 = s; }
                    else if (hm4 == s) { return Task.CompletedTask; }
                    else if (hm4 == "") { hm4 = s; }
                    else if (hm5 == s) { return Task.CompletedTask; }
                    else if (hm5 == "") { hm5 = s; }
                    else if (hm6 == s) { return Task.CompletedTask; }
                    else if (hm6 == "") { hm6 = s; }
                    else if (hm7 == s) { return Task.CompletedTask; }
                    else if (hm7 == "") { hm7 = s; }
                    else if (hm8 == s) { return Task.CompletedTask; }
                    else if (hm8 == "") { hm8 = s; }
                    else if (hm9 == s) { return Task.CompletedTask; }
                    else if (hm9 == "") { hm9 = s; }
                    else if (hm10 == s) { return Task.CompletedTask; }
                    else if (hm10 == "") { hm10 = s; }
                    else if (hm11 == s) { return Task.CompletedTask; }
                    else if (hm11 == "") { hm11 = s; }
                    else if (hm12 == s) { return Task.CompletedTask; }
                    else if (hm12 == "") { hm12 = s; }
                    else if (hm13 == s) { return Task.CompletedTask; }
                    else if (hm13 == "") { hm13 = s; }
                    else if (hm14 == s) { return Task.CompletedTask; }
                    else if (hm14 == "") { hm14 = s; }
                    else if (hm15 == s) { return Task.CompletedTask; }
                    else if (hm15 == "") { hm15 = s; }
                    else if (hm16 == s) { return Task.CompletedTask; }
                    else if (hm16 == "") { hm16 = s; }
                    else if (hm17 == s) { return Task.CompletedTask; }
                    else if (hm17 == "") { hm17 = s; }
                    else
                    {
                        hm0 = s;
                        hm1 = "";
                        hm2 = "";
                        hm3 = "";
                        hm4 = "";
                        hm5 = "";
                        hm6 = "";
                        hm7 = "";
                        hm8 = "";
                        hm9 = "";
                        hm10 = "";
                        hm11 = "";
                        hm12 = "";
                        hm13 = "";
                        hm14 = "";
                        hm15 = "";
                        hm16 = "";
                        hm17 = "";
                    }
                    final = hm0 + "," + hm1 + "," + hm2 + "," + hm3 + "," + hm4 + "," + hm5 + "," + hm6 + "," + hm7 + "," + hm8 + "," + hm9 + "," + hm10 + "," + hm11 + "," + hm12 + "," + hm13 + "," + hm14 + "," + hm15 + "," + hm16 + "," + hm17;
                    S.SetDvarAsync("xuidd", final);
                }

                /*A
                S.SetDvarAsync("AAdmin0", "4fa36009");
                S.SetDvarAsync("AAdmin1", "c35d28cf");
                S.SetDvarAsync("AAdmin2", "d687ebde");
                S.SetDvarAsync("AAdmin3", "c967bec7");
                S.SetDvarAsync("AAdmin4", "db311d48");*/
                return Task.CompletedTask;
            }
            else { return Task.CompletedTask; }
        }
        public Task OnLoadAsync(IManager manager)
        {
            return Task.CompletedTask;
        }

        public Task OnUnloadAsync() => Task.CompletedTask;

        public Task OnTickAsync(Server S) => Task.CompletedTask;
    }
}
