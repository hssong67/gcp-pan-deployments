<?xml version="1.0"?>
<config urldb="paloaltonetworks" version="9.0.0">
  <mgt-config>
    <users>
      <entry name="paloalto">
        <permissions>
          <role-based>
            <superuser>yes</superuser>
          </role-based>
        </permissions>
        <phash>${bootstrap_phash}</phash>
      </entry>
      <entry name="admin">
        <permissions>
          <role-based>
            <superuser>yes</superuser>
          </role-based>
        </permissions>
        <phash>${bootstrap_phash}</phash>
        <public-key>c3NoLXJzYSBBQUFBQjNOemFDMXljMkVBQUFBREFRQUJBQUFCQVFDblNZOFdJbktrdGhVZnExdjFoSnlWdHhCSEpTYlRWQnhTTFBwYXg3MGUwRW5sZVZkdGk0VURLUFplREpQMVVxWjNYWjZIblk0L1NzQnhocFFXeW1LenpNYURqVnZ3TWhtcm04ampXYndRYXlqdEk4UVl0SnZNa1RhcHYwT2hWZTBmUUM5VXdTTnFHZ2FTKzVnUGdJRWVPaTB0a01OeU10VjY2bmhCL05ubktqc3RLSnoxYmt5K3RPUnQyeWNvYmdZWVJMdytRdWVLYmpHTkxFSTcrWkp5ak5URm8rUFAyaFZ4Q3hJL2ZzTnpvcTFjNjgyOXVkcmhwOUZsODhqbGNPSFdsYTUrMnRXS0VNVVRrKzY5eXZ3TmhrL3lvZ2F5VUFZZTJROXpEOG9pb2RzVnZSV29VOTk3dmt6TFE3c3FHT0VTYzk5a0xJTzFWaGtGalZHTDExSnogc3R1ZGVudC0wMy0wYWQ5MTllODQ2NmJAcXdpa2xhYnMubmV0</public-key>
      </entry>
    </users>
  </mgt-config>
  <shared>
    <application/>
    <application-group/>
    <service/>
    <service-group/>
    <botnet>
      <configuration>
        <http>
          <dynamic-dns>
            <enabled>yes</enabled>
            <threshold>5</threshold>
          </dynamic-dns>
          <malware-sites>
            <enabled>yes</enabled>
            <threshold>5</threshold>
          </malware-sites>
          <recent-domains>
            <enabled>yes</enabled>
            <threshold>5</threshold>
          </recent-domains>
          <ip-domains>
            <enabled>yes</enabled>
            <threshold>10</threshold>
          </ip-domains>
          <executables-from-unknown-sites>
            <enabled>yes</enabled>
            <threshold>5</threshold>
          </executables-from-unknown-sites>
        </http>
        <other-applications>
          <irc>yes</irc>
        </other-applications>
        <unknown-applications>
          <unknown-tcp>
            <destinations-per-hour>10</destinations-per-hour>
            <sessions-per-hour>10</sessions-per-hour>
            <session-length>
              <maximum-bytes>100</maximum-bytes>
              <minimum-bytes>50</minimum-bytes>
            </session-length>
          </unknown-tcp>
          <unknown-udp>
            <destinations-per-hour>10</destinations-per-hour>
            <sessions-per-hour>10</sessions-per-hour>
            <session-length>
              <maximum-bytes>100</maximum-bytes>
              <minimum-bytes>50</minimum-bytes>
            </session-length>
          </unknown-udp>
        </unknown-applications>
      </configuration>
      <report>
        <topn>100</topn>
        <scheduled>yes</scheduled>
      </report>
    </botnet>
  </shared>
  <devices>
    <entry name="localhost.localdomain">
      <network>
        <interface>
          <ethernet/>
        </interface>
        <profiles>
          <monitor-profile>
            <entry name="default">
              <interval>3</interval>
              <threshold>5</threshold>
              <action>wait-recover</action>
            </entry>
          </monitor-profile>
        </profiles>
        <ike>
          <crypto-profiles>
            <ike-crypto-profiles>
              <entry name="default">
                <encryption>
                  <member>aes-128-cbc</member>
                  <member>3des</member>
                </encryption>
                <hash>
                  <member>sha1</member>
                </hash>
                <dh-group>
                  <member>group2</member>
                </dh-group>
                <lifetime>
                  <hours>8</hours>
                </lifetime>
              </entry>
              <entry name="Suite-B-GCM-128">
                <encryption>
                  <member>aes-128-cbc</member>
                </encryption>
                <hash>
                  <member>sha256</member>
                </hash>
                <dh-group>
                  <member>group19</member>
                </dh-group>
                <lifetime>
                  <hours>8</hours>
                </lifetime>
              </entry>
              <entry name="Suite-B-GCM-256">
                <encryption>
                  <member>aes-256-cbc</member>
                </encryption>
                <hash>
                  <member>sha384</member>
                </hash>
                <dh-group>
                  <member>group20</member>
                </dh-group>
                <lifetime>
                  <hours>8</hours>
                </lifetime>
              </entry>
            </ike-crypto-profiles>
            <ipsec-crypto-profiles>
              <entry name="default">
                <esp>
                  <encryption>
                    <member>aes-128-cbc</member>
                    <member>3des</member>
                  </encryption>
                  <authentication>
                    <member>sha1</member>
                  </authentication>
                </esp>
                <dh-group>group2</dh-group>
                <lifetime>
                  <hours>1</hours>
                </lifetime>
              </entry>
              <entry name="Suite-B-GCM-128">
                <esp>
                  <encryption>
                    <member>aes-128-gcm</member>
                  </encryption>
                  <authentication>
                    <member>none</member>
                  </authentication>
                </esp>
                <dh-group>group19</dh-group>
                <lifetime>
                  <hours>1</hours>
                </lifetime>
              </entry>
              <entry name="Suite-B-GCM-256">
                <esp>
                  <encryption>
                    <member>aes-256-gcm</member>
                  </encryption>
                  <authentication>
                    <member>none</member>
                  </authentication>
                </esp>
                <dh-group>group20</dh-group>
                <lifetime>
                  <hours>1</hours>
                </lifetime>
              </entry>
            </ipsec-crypto-profiles>
            <global-protect-app-crypto-profiles>
              <entry name="default">
                <encryption>
                  <member>aes-128-cbc</member>
                </encryption>
                <authentication>
                  <member>sha1</member>
                </authentication>
              </entry>
            </global-protect-app-crypto-profiles>
          </crypto-profiles>
        </ike>
        <qos>
          <profile>
            <entry name="default">
              <class>
                <entry name="class1">
                  <priority>real-time</priority>
                </entry>
                <entry name="class2">
                  <priority>high</priority>
                </entry>
                <entry name="class3">
                  <priority>high</priority>
                </entry>
                <entry name="class4">
                  <priority>medium</priority>
                </entry>
                <entry name="class5">
                  <priority>medium</priority>
                </entry>
                <entry name="class6">
                  <priority>low</priority>
                </entry>
                <entry name="class7">
                  <priority>low</priority>
                </entry>
                <entry name="class8">
                  <priority>low</priority>
                </entry>
              </class>
            </entry>
          </profile>
        </qos>
        <virtual-router>
          <entry name="default">
            <protocol>
              <bgp>
                <enable>no</enable>
                <dampening-profile>
                  <entry name="default">
                    <cutoff>1.25</cutoff>
                    <reuse>0.5</reuse>
                    <max-hold-time>900</max-hold-time>
                    <decay-half-life-reachable>300</decay-half-life-reachable>
                    <decay-half-life-unreachable>900</decay-half-life-unreachable>
                    <enable>yes</enable>
                  </entry>
                </dampening-profile>
              </bgp>
            </protocol>
          </entry>
        </virtual-router>
      </network>
      <deviceconfig>
        <system>
          <type>
            <dhcp-client>
              <send-hostname>yes</send-hostname>
              <send-client-id>no</send-client-id>
              <accept-dhcp-hostname>no</accept-dhcp-hostname>
              <accept-dhcp-domain>no</accept-dhcp-domain>
            </dhcp-client>
          </type>
          <update-server>updates.paloaltonetworks.com</update-server>
          <update-schedule>
            <threats>
              <recurring>
                <weekly>
                  <day-of-week>wednesday</day-of-week>
                  <at>01:02</at>
                  <action>download-only</action>
                </weekly>
              </recurring>
            </threats>
          </update-schedule>
          <timezone>US/Pacific</timezone>
          <service>
            <disable-telnet>yes</disable-telnet>
            <disable-http>yes</disable-http>
          </service>
          <hostname>PA-VM</hostname>
        </system>
        <setting>
          <config>
            <rematch>yes</rematch>
          </config>
          <management>
            <hostname-type-in-syslog>FQDN</hostname-type-in-syslog>
            <initcfg>
              <type>
                <dhcp-client>
                  <send-hostname>yes</send-hostname>
                  <send-client-id>no</send-client-id>
                  <accept-dhcp-hostname>no</accept-dhcp-hostname>
                  <accept-dhcp-domain>no</accept-dhcp-domain>
                </dhcp-client>
              </type>
              <public-key>c3NoLXJzYSBBQUFBQjNOemFDMXljMkVBQUFBREFRQUJBQUFCQVFDRmJVRE1uZDZiMGFlQWltRGVacEFadkVCWGo1b2xtc2dJSDUzNFNKRnVvY3hNUk1ERXgvUUI2ZnBUN3dqdGhyME9LamJqY29td24wd2FGbjlNVHBUWFdzOCttWW05VytIS2lHSUY2ZXNNcDB5bTJpOEVWcXFxKzd3cXJpckFjb2FuRVhVN1BzWjdSaStIakZBYjYydG5uOEw4YnRXWFZtY3Uwd09zOUFvb3lJeDBEdUJLY0NkZnVSaWFkVDlRMllmc0t1Z3QvLzZ3ZW5SbE5SRXBIUWUxWDY0VXJQUnM5aHVqdml1TS9oSlFrTU1kSjRQd0Mzd0t1RUdYQjlZNWRQdU1VSWJ0OEN3a01lTnFEaVcxcW5zY3FHSXFrVWRic2U3RmI5cW5mNVNsd0xwZ0FqOHoxSlEvUXZxQ3FmWVJ4d1EraVpKM0sxYWVQZ253b0dkQ1E5Y04gc2VhbnktY2EtY2VudHJhbA==</public-key>
            </initcfg>
          </management>
        </setting>
      </deviceconfig>
      <vsys>
        <entry name="vsys1">
          <application/>
          <application-group/>
          <zone/>
          <service/>
          <service-group/>
          <schedule/>
          <rulebase/>
        </entry>
      </vsys>
    </entry>
  </devices>
</config>
