*************************************************************
*Start of Program
*Declaring Strcutrure for header
TYPES: BEGIN OF ty_header,
         order_number TYPE zar_order_number,
         order_date   TYPE zar_order_date,
         payment_mode TYPE zar_payment_mode,
         currency     TYPE zar_curency,
       END OF ty_header.

*********************
*Internal table and Work Area
DATA : lt_header TYPE TABLE OF ty_header,
       ls_header TYPE ty_header.

*******************************
*Select option Declaration
DATA : lv_order TYPE zar_order_number.
SELECT-OPTIONS : s_order  FOR lv_order.

*********************************
*Writing a select query for header
START-OF-SELECTION.
  SELECT order_number order_date
    payment_mode currency
    FROM zar_header INTO
    TABLE lt_header
    WHERE order_number IN s_order.

***************************************
*Displaying the data
  LOOP AT lt_header INTO ls_header.
    WRITE :/ ls_header-order_number,
             ls_header-order_date,
             ls_header-payment_mode,
             ls_header-currency.

  ENDLOOP.
*********************************
*SET PF STATUS
  SET PF-STATUS  'FUNCTION'.

**********************
*At User Command
AT USER-COMMAND.
  IF sy-ucomm EQ 'ASCENDING'.
    SORT lt_header BY order_number.
    LOOP AT lt_header INTO ls_header.
      WRITE :/ ls_header-order_number,
               ls_header-order_date,
               ls_header-payment_mode,
               ls_header-currency.

    ENDLOOP.

  ELSEIF sy-ucomm EQ 'DESCENDING'.
    SORT lt_header BY order_number DESCENDING.
    LOOP AT lt_header INTO ls_header.
      WRITE :/ ls_header-order_number,
               ls_header-order_date,
               ls_header-payment_mode,
               ls_header-currency.

    ENDLOOP.
  ENDIF.

******************
*END OF PROGRAM
************************************************************
