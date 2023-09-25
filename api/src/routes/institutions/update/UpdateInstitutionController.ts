import { Response, Request } from 'express';
import { handleErrorDefault, handleResult } from '../../../utils';
import { UpdateInstitutionService } from './UpdateInstitutionService';

export class UpdateInstitutionController {
  async handle(req: Request, res: Response) {
    const { name } = req.body;
    const {id} = req.params;

    const service = new UpdateInstitutionService();

    try {
      const result = await service.execute(+id, name);

      return handleResult(res, result);

    } catch (err) {
      return handleErrorDefault(res, err);
    }
  }
}