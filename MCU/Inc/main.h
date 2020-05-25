/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2020 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at:
  *                        opensource.org/licenses/BSD-3-Clause
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f1xx_hal.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
void Error_Handler(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
#define User_LED_Pin GPIO_PIN_13
#define User_LED_GPIO_Port GPIOC
#define R_Bumper_Pin GPIO_PIN_14
#define R_Bumper_GPIO_Port GPIOC
#define L_Bumper_Pin GPIO_PIN_15
#define L_Bumper_GPIO_Port GPIOC
#define ADC0_Pin GPIO_PIN_0
#define ADC0_GPIO_Port GPIOA
#define ADC1_Pin GPIO_PIN_1
#define ADC1_GPIO_Port GPIOA
#define ADC4_Pin GPIO_PIN_4
#define ADC4_GPIO_Port GPIOA
#define R_Dir_Pin GPIO_PIN_5
#define R_Dir_GPIO_Port GPIOA
#define R_Step_Pin GPIO_PIN_6
#define R_Step_GPIO_Port GPIOA
#define Interrupt0_Pin GPIO_PIN_7
#define Interrupt0_GPIO_Port GPIOA
#define Step_M2_Pin GPIO_PIN_12
#define Step_M2_GPIO_Port GPIOB
#define Step_M1_Pin GPIO_PIN_13
#define Step_M1_GPIO_Port GPIOB
#define Step_M0_Pin GPIO_PIN_14
#define Step_M0_GPIO_Port GPIOB
#define Step_EN_Pin GPIO_PIN_15
#define Step_EN_GPIO_Port GPIOB
#define L_Step_Pin GPIO_PIN_15
#define L_Step_GPIO_Port GPIOA
#define L_Dir_Pin GPIO_PIN_3
#define L_Dir_GPIO_Port GPIOB
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
