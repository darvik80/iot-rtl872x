#ifndef __EXAMPLE_SPI_ATCMD_H__
#define __EXAMPLE_SPI_ATCMD_H__

#if CONFIG_EXAMPLE_SPI_ATCMD

#define SPI0_MOSI  PA_12
#define SPI0_MISO  PA_13
#define SPI0_SCLK  PA_14
#define SPI0_CS    PA_15

#define GPIO_CS    PB_3
#define GPIO_HRDY  PA_25
#define GPIO_SYNC  PB_26

void example_spi_atcmd(void);

#endif // #if CONFIG_EXAMPLE_SPI_ATCMD

#endif // #ifndef __EXAMPLE_SPI_ATCMD_H__