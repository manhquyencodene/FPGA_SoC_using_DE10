#include <stdio.h>
#include "system.h"
#include "altera_avalon_pio_regs.h"
#include <unistd.h>

unsigned char hex_table[] = {
    0x40, 0x79, 0x24, 0x30, 0x19,
    0x12, 0x02, 0x78, 0x00, 0x10
};

void update_display(int h, int m, int s) {
    IOWR_ALTERA_AVALON_PIO_DATA(HEX0_BASE, hex_table[s % 10]);
    IOWR_ALTERA_AVALON_PIO_DATA(HEX1_BASE, hex_table[s / 10]);
    IOWR_ALTERA_AVALON_PIO_DATA(HEX2_BASE, hex_table[m % 10]);
    IOWR_ALTERA_AVALON_PIO_DATA(HEX3_BASE, hex_table[m / 10]);
    IOWR_ALTERA_AVALON_PIO_DATA(HEX4_BASE, hex_table[h % 10]);
    IOWR_ALTERA_AVALON_PIO_DATA(HEX5_BASE, hex_table[h / 10]);
}

int main() {
    int hour = 0, min = 0, sec = 0;
    int sw_data;

    printf("Clock System Started\n");

    while (1) {
        sw_data = IORD_ALTERA_AVALON_PIO_DATA(SWITCH_BASE);

        if (sw_data & 0x200) {
            int mode = (sw_data >> 7) & 0x03;
            int value = sw_data & 0x3F;

            if (mode == 0) {
                sec = (value < 60) ? value : 59;
            } else if (mode == 1) {
                min = (value < 60) ? value : 59;
            } else if (mode == 2) {
                hour = (value < 24) ? value : 23;
            }
        } else {
            sec++;
            if (sec >= 60) {
                sec = 0;
                min++;
            }
            if (min >= 60) {
                min = 0;
                hour++;
            }
            if (hour >= 24) {
                hour = 0;
            }
            usleep(1000000);
        }

        update_display(hour, min, sec);
    }

    return 0;
}
