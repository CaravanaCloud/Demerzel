from rdklib import Evaluator, Evaluation, ConfigRule, ComplianceType
import datetime
import logging
log = logging.getLogger()

class a9n(ConfigRule):
    def evaluate_change(self, event, client_factory, configuration_item, valid_rule_parameters):
        resource_type = configuration_item.get("resourceType")
        resource_id = configuration_item.get("resourceId")
        log.info("Evaluating change [%s] [%s]", resource_type, resource_id)
        log.debug("valid client parameters")
        log.debug(str(valid_rule_parameters))
        log.debug("event")
        log.debug(str(event))
        evaluation = Evaluation(ComplianceType.COMPLIANT, resourceId=resource_id, resourceType=resource_type, annotation="a9n")
        evaluations = [evaluation]
        return []

    def evaluate_periodic(self, event, client_factory, valid_rule_parameters):
        resource_type = event.get("resourceType")
        resource_id = event.get("resourceId")                                                                                                                            
        log.info("Evaluating periodic rule [%s] [%s]", resource_type, resource_id)
        log.debug("valid client parameters")
        log.debug(str(valid_rule_parameters))
        log.debug("event")
        log.debug(str(event))
        evaluation = Evaluation(ComplianceType.COMPLIANT, resourceId=resource_id, resourceType=resource_type, annotation="a9n")
        evaluations = [evaluation]
        return []

    def evaluate_parameters(self, rule_parameters):
        valid_rule_parameters = rule_parameters
        return valid_rule_parameters


################################
# DO NOT MODIFY ANYTHING BELOW #
################################
def lambda_handler(event, context):
    my_rule = a9n()
    evaluator = Evaluator(my_rule)
    return evaluator.handle(event, context)
