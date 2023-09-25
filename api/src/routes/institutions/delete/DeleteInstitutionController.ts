import { Response, Request } from 'express';
import { handleErrorDefault, handleResult } from '../../../utils';
import { DeleteInstitutionService } from './DeleteInstitutionService';

export class DeleteInstitutionController {
  async handle(req: Request, res: Response) {
    const { id } = req.params;
    const service = new DeleteInstitutionService();

    try {
      const result = await service.execute(+id);
      return handleResult(res, result);

    } catch (err) {
      return handleErrorDefault(res, err);
    }
  }
}