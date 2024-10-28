package edu.jmu.sudi.utils;

import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;

/**
 * 文件上传工具类
 * @author LiangJie
 */
public class FileUploadUtil {

    /**
     * 文件重命名
     * @param file
     * @return
     */
    public static String rename(MultipartFile file){
        //获取后缀名
        String extension = FilenameUtils.getExtension(file.getOriginalFilename());
        //文件重命名
        return UUIDUtil.randomUUID() + "." + extension;
    }
}
