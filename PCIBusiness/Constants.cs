﻿using System;

namespace PCIBusiness
{
	public static class Constants
	{

	//	General stand-alone constants
	//	-----------------------------
		public static DateTime C_NULLDATE()
		{
			return System.Convert.ToDateTime("1799/12/31");
		}
		public static string C_HTMLBREAK()
		{
			return "<br />";
		}
		public static string C_TEXTBREAK()
		{
			return Environment.NewLine; // "\n";
		}
		public static short C_MAXSQLROWS()
		{
			return 100;
		}
		public static short C_MAXPAYMENTROWS()
		{
			return 50;
		}
		public enum DBColumnStatus : byte
		{
			InvalidColumn = 1,
			EOF           = 2,
			ValueIsNull   = 3,
			ColumnOK      = 4
		}

		public enum PaymentStatus : byte
		{
			WaitingToPay     =   1,
			FailedTryAgain   =  21,
			FailedDoNotRetry =  22,
			BusyProcessing   =  51,
			Successful       = 101
		}

		public enum PaymentProvider : int
		{
			MyGate     =  2,
			T24        =  6,
			Ikajo      = 15,
			PayU       = 16,
			PayGate    = 17,
			PayGenius  = 18,
			Ecentric   = 19,
			eNETS      = 20

//	Not implemented yet
//			DinersClub = 21
//			PayFast    = 22
		}

		public enum CreditCardType : byte
		{
			Visa            = 1,
			MasterCard      = 2,
			AmericanExpress = 3,
			DinersClub      = 4
		}

		public enum PagingMode : byte
		{
			None              = 0,
			AllowScreenPaging = 209,
			DoNotReadNextRow  = 244
		}

		public enum BureauStatus : byte
		{
			Unknown     = 0,
			Development = 1,
			Testing     = 2,
			Live        = 3
		}

		public enum SystemMode : byte
		{
			Development = 1,
			Test        = 2,
			Live        = 3
		}
		public enum ProcessMode : int
		{
			FullUpdate                 =  0, // Live
			UpdateToken                = 10,
			DeleteToken                = 11,
			UpdatePaymentStep1         = 21,
			UpdatePaymentStep2         = 22,
			UpdatePaymentStep1AndStep2 = 23,
			NoUpdate                   = 99
		}
		public enum TransactionType : byte
		{
			GetToken       =  1,
			TokenPayment   =  2,
			CardPayment    =  3,
			DeleteToken    =  4,
			ManualPayment  = 73
		}
//		public enum PaymentType : byte
//		{
//			Tokens      = 10,
//			CardNumbers = 20,
//			Vault       = 30
//		}
	}
}