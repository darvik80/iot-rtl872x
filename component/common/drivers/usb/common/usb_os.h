/**
  ******************************************************************************
  * @file    usb_ch9.h
  * @author  Realsil WLAN5 Team
  * @brief   This file provides general defines for USB SPEC CH9
  ******************************************************************************
  * @attention
  *
  * This module is a confidential and proprietary property of RealTek and
  * possession or use of this module requires written permission of RealTek.
  *
  * Copyright(c) 2021, Realtek Semiconductor Corporation. All rights reserved.
  ******************************************************************************
  */

#ifndef USB_OS_H
#define USB_OS_H

/* Includes ------------------------------------------------------------------*/

#include "platform_autoconf.h"

#ifdef CONFIG_RTL8721D
#define STD_PRINTF

#include "platform_stdlib.h"
#include "log.h"
#endif

#include "basic_types.h"
#include "osdep_service.h"

/* Exported defines ----------------------------------------------------------*/

/* Exported types ------------------------------------------------------------*/

#ifndef CONFIG_FLOADER_USBD_EN
typedef _lock usb_spinlock_t;
#endif

/* Exported macros -----------------------------------------------------------*/

#ifndef UNUSED
#define UNUSED(X)			(void)X
#endif

#ifndef USB_DMA_ALIGNED
#define USB_DMA_ALIGNED		__attribute__((aligned(CACHE_LINE_SIZE)))
#endif

#ifndef USB_IS_MEM_DMA_ALIGNED
#define USB_IS_MEM_DMA_ALIGNED(x)		((u32)((u32)(x) & ((CACHE_LINE_SIZE)-1)) == 0)
#endif

#ifndef USB_LOW_BYTE
#define USB_LOW_BYTE(x)		((u8)((x) & 0x00FFU))
#endif

#ifndef USB_HIGH_BYTE
#define USB_HIGH_BYTE(x)	((u8)(((x) & 0xFF00U) >> 8U))
#endif

#ifndef MIN
#define MIN(a, b)			(((a) < (b)) ? (a) : (b))
#endif

#ifndef MAX
#define MAX(a, b)			(((a) > (b)) ? (a) : (b))
#endif

/* Exported variables --------------------------------------------------------*/

/* Exported functions --------------------------------------------------------*/

void usb_os_sleep_ms(u32 ms);

void usb_os_delay_us(u32 us);

void usb_os_memset(void *buf, u8 val, u32 size);

void usb_os_memcpy(void *dst, const void *src, u32 size);

#ifndef CONFIG_FLOADER_USBD_EN

void *usb_os_malloc(u32 size);

void usb_os_mfree(void *handle);

usb_spinlock_t *usb_os_spinlock_alloc(void);

void usb_os_spinlock_free(usb_spinlock_t *lock);

void usb_os_spinlock(usb_spinlock_t *lock);

void usb_os_spinunlock(usb_spinlock_t *lock);

void usb_os_spinlock_safe(usb_spinlock_t *lock);

void usb_os_spinunlock_safe(usb_spinlock_t *lock);

#endif

#endif /* USB_OS_H */

