container:
	make gameserver
	make metamod
	make kz

gameserver:
	steamcmd \
		+force_install_dir /cs2kz/server \
		+login anonymous \
		+app_update 730 validate \
		+quit

	mkdir -p /root/.steam/sdk64/
	cp /root/.local/share/Steam/steamcmd/linux64/steamclient.so /root/.steam/sdk64/steamclient.so

metamod:
	curl -L "https://mms.alliedmods.net/mmsdrop/2.0/mmsource-2.0.0-git1270-linux.tar.gz" \
		-o /cs2kz/server/game/csgo/metamod.tar.gz

	cd /cs2kz/server/game/csgo/ \
		&& tar -xvzvf metamod.tar.gz \
		&& rm metamod.tar.gz

	[ $$(grep "metamod" server/game/csgo/gameinfo.gi | wc -l) -eq 0 ] \
		&& sed -i '22 s/^/\r\n\t\t\tGame\tcsgo\/addons\/metamod\r\n/' /cs2kz/server/game/csgo/gameinfo.gi \
		|| exit 0

metamod-clean:
	rm -rf /cs2kz/server/game/csgo/addons

kz:
	cp -r cs2kz/addons/cs2kz server/game/csgo/addons/
	cp -r cs2kz/addons/metamod/* server/game/csgo/addons/metamod/
	cp cs2kz/cfg/cs2kz.cfg server/game/csgo/

run:
	/cs2kz/server/game/cs2.sh \
		-dedicated \
		+sv_lan 1 \
		+ip 0.0.0.0 \
		+port 27015 \
		+map de_mirage \
		+host_workshop_map 3070194623

clean:
	rm -rf server
