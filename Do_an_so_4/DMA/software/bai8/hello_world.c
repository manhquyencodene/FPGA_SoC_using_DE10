#include <stdio.h>
#include "system.h"
#include "altera_avalon_dma_regs.h"
#include "sys/alt_irq.h"
//pdata0 points to a global array stored in onchip_memory2_0
char pdata0[32] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
16,
        17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31 };
//pdata1 points to onchip_memory2_1
char *pdata1 = (char*) (ONCHIP_MEMORY2_1_BASE);
//Interrupt handler of DMA
void DMA_ISR_Handler(void* isr_context) {
    int i;
    // Read and print data in onchip_memory2_1
    for (i = 0; i < 32; i++) {
        printf("byte %d = %d\n", i, pdata1[i]);
    }
    //Clear DMA Interrupt bit
    IOWR_ALTERA_AVALON_DMA_STATUS(DMA_0_BASE, 0);
}
//Initialize function of DMA
void DMA_Init(void) {
    //De-init DMA
    IOWR_ALTERA_AVALON_DMA_CONTROL(DMA_0_BASE, 0);
    // Source address is pdata0
    IOWR_ALTERA_AVALON_DMA_RADDRESS(DMA_0_BASE, (int )pdata0);
    // Destination address is pdata1
    IOWR_ALTERA_AVALON_DMA_WADDRESS(DMA_0_BASE, (int )pdata1);
    // Length is 32 bytes
    IOWR_ALTERA_AVALON_DMA_LENGTH(DMA_0_BASE, 32);
    // Configure and Start DMA with byte transfer, end transaction when
//length reach zero, interrupt enable and start DMA
    IOWR_ALTERA_AVALON_DMA_CONTROL(DMA_0_BASE,
        ALTERA_AVALON_DMA_CONTROL_BYTE_MSK |
ALTERA_AVALON_DMA_CONTROL_LEEN_MSK | ALTERA_AVALON_DMA_CONTROL_I_EN_MSK |
ALTERA_AVALON_DMA_CONTROL_GO_MSK);
}
int main() {
    DMA_Init();
    alt_ic_isr_register(0, DMA_0_IRQ, DMA_ISR_Handler, (void*) 0,
(void*) 0);
    while (1)
        ;
    return 0;
}
