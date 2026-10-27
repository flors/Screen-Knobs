#!/bin/bash

echo "LLAÇADES ENTRELLAÇADES"
sleep 30

if wlr-randr | grep -q "HDMI-A-1"; then
	echo "--> tenim pantalla HDMI-A-1 gran"
		if wlr-randr | grep -q "HDMI-A-2"; then
			echo "--> tenim pantalla HDMI-A-2 petita"
			echo "--> ole ole tenim 2 pantalles"
			echo "------ ajustem i girem pantalla petita"
			wlr-randr --output HDMI-A-2 --transform 90
			sleep 3
			wlr-randr --output HDMI-A-2 --mode 800x480
			sleep 3
			echo "------ tambe ajustem i girem pantalla gran"
			wlr-randr --output HDMI-A-1 --transform 90
			sleep 3
			wlr-randr --output HDMI-A-1 --mode 1920x1080
			sleep 3
			echo "------ llancem apps a la petita (2) i a la gran (1) & engeguem el client osc"
			/home/gerd/sketchbook/sketch_260430a_LLEGEIX_i_envia_OSC/linux-aarch64/sketch_260430a_LLEGEIX_i_envia_OSC &
			/home/gerd/sketchbook/sketch_260430b_repe_vertical_LLEGEIX_OSC_mini_totdins1/linux-aarch64/sketch_260430b_repe_vertical_LLEGEIX_OSC_mini_totdins1 &
			/home/gerd/sketchbook/sketch_260430b_repe_vertical_LLEGEIX_OSC_mini_totdins2/linux-aarch64/sketch_260430b_repe_vertical_LLEGEIX_OSC_mini_totdins2
			echo "--> VA BE"
		else
			echo "--> NO tenim pantalla HDMI-A-2 petita"
			echo "------ ajustem i girem pantalla i llancem app a la gran (1) & engeguem el client osc"
			wlr-randr --output HDMI-A-1 --transform 90
			sleep 3
			wlr-randr --output HDMI-A-1 --mode 1920x1080
			sleep 3
			/home/gerd/sketchbook/sketch_260430a_LLEGEIX_i_envia_OSC/linux-aarch64/sketch_260430a_LLEGEIX_i_envia_OSC &
			/home/gerd/sketchbook/sketch_260430b_repe_vertical_LLEGEIX_OSC_mini_totdins1/linux-aarch64/sketch_260430b_repe_vertical_LLEGEIX_OSC_mini_totdins1
			echo "--> VA BE"
		fi

else
	echo "--> NO tenim pantalla HDMI-A-1 gran"
		if wlr-randr | grep -q "HDMI-A-2"; then
			echo "--> tenim pantalla HDMI-A-2 petita"
			echo "------ ajustem i girem pantalla i llancem app a la petita (1) & engeguem el client osc"
			wlr-randr --output HDMI-A-2 --transform 90
			sleep 3
			wlr-randr --output HDMI-A-2 --mode 800x480
			sleep 3
			/home/gerd/sketchbook/sketch_260430a_LLEGEIX_i_envia_OSC/linux-aarch64/sketch_260430a_LLEGEIX_i_envia_OSC &
			/home/gerd/sketchbook/sketch_260430b_repe_vertical_LLEGEIX_OSC_mini_totdins1/linux-aarch64/sketch_260430b_repe_vertical_LLEGEIX_OSC_mini_totdins1
			echo "--> VA BE"
		else
			echo "--> NO tenim pantalla HDMI-A-2 petita"
			echo "------ no tenim pantalles de cap mena :-( no podem veure res"
		fi
fi