import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Send OTP → verify with 6-digit OTP, 30s resend cooldown (patient login).
class PatientOtpSection extends StatefulWidget {
  const PatientOtpSection({
    super.key,
    required this.phoneReadOnly,
    required this.phoneController,
    required this.onSendOtp,
    required this.onVerify,
    required this.sendLoading,
    required this.verifyLoading,
    required this.sendError,
    required this.verifyError,
    required this.showSendStep,
    required this.resendSecondsLeft,
    required this.onResend,
  });

  final bool phoneReadOnly;
  final TextEditingController phoneController;
  final VoidCallback onSendOtp;
  final void Function(String otp) onVerify;
  final bool sendLoading;
  final bool verifyLoading;
  final String? sendError;
  final String? verifyError;
  final bool showSendStep;
  final int resendSecondsLeft;
  final VoidCallback onResend;

  @override
  State<PatientOtpSection> createState() => _PatientOtpSectionState();
}

class _PatientOtpSectionState extends State<PatientOtpSection> {
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: widget.phoneController,
          readOnly: widget.phoneReadOnly,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: 'Phone number',
            prefixText: '+91 ',
            border: const OutlineInputBorder(),
            errorText: widget.sendError,
            counterText: '',
          ),
        ),
        const SizedBox(height: 16),
        if (widget.showSendStep) ...[
          FilledButton(
            onPressed: widget.sendLoading ? null : widget.onSendOtp,
            child: Text(widget.sendLoading ? 'Sending…' : 'Send OTP'),
          ),
        ] else ...[
          TextField(
            controller: _otpController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: 'OTP',
              border: const OutlineInputBorder(),
              errorText: widget.verifyError,
              counterText: '',
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: (widget.verifyLoading || _otpController.text.length != 6)
                ? null
                : () => widget.onVerify(_otpController.text),
            child: Text(widget.verifyLoading ? 'Verifying…' : 'Verify OTP'),
          ),
          const SizedBox(height: 8),
          Center(
            child: widget.resendSecondsLeft > 0
                ? Text("Didn't receive the OTP? Resend in ${widget.resendSecondsLeft}s")
                : TextButton(
                    onPressed: widget.verifyLoading ? null : widget.onResend,
                    child: const Text('Resend OTP'),
                  ),
          ),
        ],
      ],
    );
  }
}
