class ApiEndpoints {
  const ApiEndpoints._();

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String passwordResetRequest = '/auth/reset/request';
  static const String passwordReset = '/auth/reset';
  static const String verifyCode = '/auth/verify';
  static const String me = '/auth/me';

  static const String assistants = '/assistants';
  static String assistant(String id) => '/assistants/$id';
  static String instructionSets(String assistantId) => '/assistants/$assistantId/instructions';

  static const String conversations = '/chat/conversations';
  static String conversation(String id) => '/chat/conversations/$id';
  static String messages(String conversationId) => '/chat/conversations/$conversationId/messages';
  static String regenerateMessage(String messageId) => '/chat/messages/$messageId/regenerate';

  static const String subscriptions = '/billing/subscriptions';
  static String subscription(String id) => '/billing/subscriptions/$id';
  static const String plans = '/billing/plans';
  static const String paymentMethods = '/billing/payment-methods';
  static String paymentMethod(String id) => '/billing/payment-methods/$id';

  static const String services = '/services';
}
